# Plot Boston house prices against room count.

import numpy as np
from sklearn import datasets
from matplotlib import pyplot as plt

def main():
    # Load the Boston data set
    boston = datasets.load_boston()
    # Number of rooms
    rooms = boston.data[:, 5]
    # House price
    house_prices = boston.target

    plt.scatter(rooms, house_prices, color='r')

    # Find the least squares line
    x = np.array([[v, 1] for v in rooms])  # add the bias term
    y = house_prices
    (slope, bias), total_error, _, _ = np.linalg.lstsq(x, y)

    # Plot the fitted line
    plt.plot(x[:, 0], slope * x[:, 0] + bias)

    # RMSE of the training error
    rmse = np.sqrt(total_error[0] / len(x))
    msg = 'RMSE (training): {0}'.format(rmse)
    print(msg)

    # Show the graph
    plt.xlabel('Number of Room')
    plt.ylabel('Price of House ($1,000)')
    plt.grid()
    plt.show()
    plt.savefig('image.png')

if __name__ == '__main__':
    main()
