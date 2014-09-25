#!/usr/bin/env python3
# 2013-12-11
# updating
# 2014-08-23
# re-updating

# IDEA: make a collection of values that never escape, test for those on
# iteration? that could save us time, or more than double it.

from __future__ import division, print_function

import argparse
from matplotlib import pyplot as plt
from matplotlib.colors import hsv_to_rgb
import numpy as np

class OnMoveCallback(object):
    def __init__(self, args):
        self.args = args

    def __call__(self, event):
        if event.key != 'enter':
            return
        axes = event.canvas.figure.get_axes()[0]
        xbound = axes.get_xbound()
        ybound = axes.get_ybound()

        x_range = granulated_range(xbound[0], xbound[1], self.args.granularity)
        y_range = granulated_range(ybound[0], ybound[1], self.args.granularity)

        print('processing')
        data = process(x_range, y_range, self.args.maxiter, self.args.scale)

        print('plotting')
        plt.imshow(data, interpolation='none', extent=(xbound + ybound),
                origin='lower')
        plt.show()


def main():
    args = getargs()

    x_range = granulated_range(args.ranges[0], args.ranges[2],
            args.granularity)
    y_range = granulated_range(args.ranges[1], args.ranges[3],
            args.granularity)

    extent = (args.ranges[0], args.ranges[2],
              args.ranges[3], args.ranges[1])

    print('processing')

    data = process(x_range, y_range, args.maxiter, args.scale)

    print('plotting')

    callback = OnMoveCallback(args)
    plt.connect('key_press_event', callback)

    plt.imshow(data, interpolation='none', extent=extent, origin='lower')
    plt.gca().invert_yaxis()
    plt.show()


def getargs():
    parser = argparse.ArgumentParser(description='produce an mandelbrot plot')
    parser.add_argument('-r', '--ranges', type=float, nargs=4,
            default=[-2.0, -2.0, 2.0, 2.0],
            help='what section of the set to calculate.')
    parser.add_argument('-o', '--outfile', default='mandelbrot.png',
            help='what to call the resulting PNG image file.');
    parser.add_argument('-e', '--errfile', default=None,
            help='where to log any errors that result.')
    parser.add_argument('-m', '--maxiter', default=70, type=int,
            help='the number of iterations to run per point.')
    parser.add_argument('-g', '--granularity', default=500, type=int,
            help='the number of points to calculate per axis.')
    parser.add_argument('-s', '--scale', default=25, type=int,
            help='a scaling value by which to loop colors')
    return parser.parse_args()


def process(x_range, y_range, maxiter, scale):
    x_range = list(x_range)
    y_range = list(y_range)
    # data = np.zeros((len(x_range), len(y_range), 3), dtype=float)
    data = np.zeros((len(x_range), len(y_range)), dtype=float)

    # to_hsv = get_HSV_conversion_func(scale)

    for i, y in enumerate(y_range):
        try:
            for j, x in enumerate(x_range):
                # data[i, j] = to_hsv(iterations_to_escape(x, y, maxiter))
                data[i, j] = iterations_to_escape(x, y, maxiter)
        except IndexError:
            pass

    # return hsv_to_rgb(data)
    return data


# return values between start and stop at the specified granularity
def granulated_range(start, stop=None, gran=1):
    if stop == None:
        stop = start
        start = 0
        if stop < 0:
            start, stop = stop, start
    val = start
    step = (stop - start) / gran
    if step == 0:
        raise ValueError('Step value is 0 at this granularity.')
    while val < stop:
        yield val
        val += step

# the test function
def iterations_to_escape(x, y, maxiter):
    # z starts at 0,0j
    z = complex(0, 0)
    # c will always be our coordinates
    c = complex(x, y)
    # i is the iteration we are on
    i = 0

    while abs(z) < 2:
        # our magic function
        z = z*z + c
        # increment our iteration count
        i += 1
        # if we go over our max iteration count, then we don't know that this
        # point *isn't* in the set. if the magnitude of z ever goes above 2,
        # then we *know* it's not in the set.
        if i >= maxiter:
            # return None
            break

    return i

def get_HSV_conversion_func(scale):
    def to_hsv(n):
        if isinstance(n, int):
            return ((n / scale) % 1, 1, 1)
        else:
            return (0, 0, 0)
    return to_hsv

if __name__ == '__main__':
    main()
