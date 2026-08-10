
# http://sinhrks.hatenablog.com/entry/2014/12/14/005604

import numpy as np
import simpy
import matplotlib.pyplot as plt
import matplotlib.animation as animation

env = simpy.Environment()

class Car(object):

    # Unit of time between speed updates
    step = 5

    def __init__(self, env, mean, std):
        # Reference to the simulation environment
        self.env = env

        # Mean speed
        self.mean = mean
        # Standard deviation of the speed
        self.std = std

        # Current speed
        self.velocity = 0.0
        # Current position
        self.location = 0.0
        # Previous position
        self.prev_location = 0.0

    def update_velocity(self):
        # Update the current speed
        # The speed follows a normal distribution with mean mean and deviation std
        v = np.random.normal(self.mean, self.std)
        if v < 0:
            v = 0
        return v

    def update_location(self):
        # Update the current position
        self.prev_location = self.location
        self.location += self.velocity / 3600 * 1000
        return self.location

    def run(self):
        # Return this object's own process generator
        while True:
            if env.now % self.step == 0:
                # Redraw the speed at random every time step elapses
                self.velocity = self.update_velocity()
            form = '現在時刻 {0:2d} 位置: {1:.1f} m 時速 {2:.1f} km'
            print(form.format(self.env.now, self.location, self.velocity))
            self.update_location()
            yield self.env.timeout(1)

class Car2(Car):

    def __init__(self, env, number, mean, std, fdist=20, ahead=None):
        super(Car2, self).__init__(env, mean, std)
        # Number of the car
        self.number = number
        # Reference to the Car ahead of this one
        self.ahead = ahead

        # fdist is the following distance set at initialization
        self.location = - number * fdist

    def run(self):
        while True:
            if env.now % self.step == 0:
                self.velocity = self.update_velocity()
            form = '現在時刻 {0:2d} 番号 {1} 位置: {2:.1f} m 時速 {3:.1f} km'
            message = form.format(
                self.env.now, self.number, self.location, self.velocity)
            self.update_location()

            # When a car is ahead, close up to 1 m behind its position
            if self.ahead is not None:
                if self.location >= self.ahead.location - 1:
                    self.location = self.ahead.location - 1
                    # Print an asterisk when blocked by the car ahead
                    message += ' *'
            print(message)
            yield self.env.timeout(1)

    @property
    def actual_velocity(self):
        # Derive the speed from the distance actually covered since the last position
        v = (self.location - self.prev_location) * 3600 / 1000
        return v

def init_env(env, num_cars=5, mean=72, std=10, fdist=20):
    cars = []
    prev = None
    # Create as many Car2 instances as num_cars asks for
    for i in range(num_cars):
        c = Car2(env, number=i, mean=mean, std=std, fdist=fdist, ahead=prev)
        env.process(c.run())
        prev = c
        cars.append(c)
    return env, cars

np.random.seed(1)
env = simpy.Environment()

# Group 1: 20 cars starting 20 m apart
env, cars1 = init_env(env, num_cars=20, fdist=20)

# Group 2: 20 cars starting 60 m apart
env, cars2 = init_env(env, num_cars=20, fdist=60)

# Create the figure and axes for drawing
fig, (ax1, ax2) = plt.subplots(2, 1, figsize=(7, 4))
ax1.set_ylim(0, 80)
ax2.set_xlim(-1000, 2000)
ax2.xaxis.set_visible(False)
ax2.yaxis.set_visible(False)
objs = []
velocities1 = []
velocities2 = []

# Loop over 200 time units for 40 cars
for i in range(200 * 40):
    if i % 40 == 0:
        # Average the speed of each group
        velocities1.append(np.mean([c.actual_velocity for c in cars1]))
        velocities2.append(np.mean([c.actual_velocity for c in cars2]))

        # Draw the line chart
        l1 = ax1.plot(range(len(velocities1)), velocities1, color='#c92b2b')
        l2 = ax1.plot(range(len(velocities2)), velocities2, color='#005ec4')

        # Draw the position of each group
        pt1 = ax2.scatter(
            [c.location for c in cars1], [2] * len(cars1), color='#c92b2b')
        pt2 = ax2.scatter(
            [c.location for c in cars2], [1] * len(cars2), color='#005ec4')
        objs.append(tuple(l1) + tuple(l2) + (pt1, pt2))

    # Advance the simulation by one step, that is until the next process runs
    env.step()

ax1.legend([l1[0], l2[0]], ['車間初期値20m', '車間初期値60m'], loc=4)
# Animation settings
ani = animation.ArtistAnimation(fig, objs, interval=1, repeat=False)

plt.show()
plt.savefig("image.png")
