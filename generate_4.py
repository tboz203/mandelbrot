#!/usr/bin/env python3
# 2013-12-11
# updating
# 2014-08-23
# re-updating

from __future__ import division, print_function

import argparse
from matplotlib import pyplot

def main():
    args = getargs()

    x_range = granulated_range(args.ranges[0],
            args.ranges[0] + args.ranges[2],
            args.granularity)
    y_range = granulated_range(args.ranges[1],
            args.ranges[1] + args.ranges[2],
            args.granularity)

    extent = (args.ranges[0], args.ranges[0] + args.ranges[2],
              args.ranges[1] + args.ranges[2], args.ranges[1])

    print('processing')

    data = process(x_range, y_range, args.maxiter)

    print('plotting')

    pyplot.imshow(data, interpolation='none', extent=extent)
    pyplot.gca().invert_yaxis()
    pyplot.show()


def getargs():
    parser = argparse.ArgumentParser(description='produce an mandelbrot plot')
    parser.add_argument('-r', '--ranges', type=float, nargs=3,
            default=[-2.0, -2.0, 4.0],
            help='what section of the set to calculate.')
    parser.add_argument('-o', '--outfile', default='mandelbrot.png',
            help='what to call the resulting PNG image file.');
    parser.add_argument('-e', '--errfile', default=None,
            help='where to log any errors that result.')
    parser.add_argument('-m', '--maxiter', default=70, type=int,
            help='the number of iterations to run per point.')
    parser.add_argument('-g', '--granularity', default=500, type=int,
            help='the number of points to calculate per axis.')
    return parser.parse_args()


def process(x_range, y_range, maxiter):
    data = []
    x_range = list(x_range)
    y_range = list(y_range)

    for y in y_range:
        row = []
        for x in x_range:
            n = iterations_to_escape(x, y, maxiter)
            row += [n]
        data += [row]

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
            break

    return i


if __name__ == '__main__':
    main()
