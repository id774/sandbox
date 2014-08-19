x = 0
y = 0
l = 0.1
for i in range(400):
    if (i % 10 == 0):
        print("step:{0} (x,y)=({1:.5f},{2:.5f}) f(x,y)={3:.5f}"
              .format(i, x, y, x * x - 4 * x * y + 5 * y * y - 2 * y + 2))
    newx = x - l * (2 * x - 4 * y)
    newy = y - l * (-4 * x + 10 * y - 2)
    x = newx
    y = newy
