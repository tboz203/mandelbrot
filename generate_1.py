#!/usr/bin/env python
# 2013-12-11
# updating

from __future__ import print_function
from math import *
import os
from sys import argv
from fractions import Fraction as f

# the point density
granularity = 1000
# maximum number of iterations (the accuracy of the plot).
maxiter = 70

def main():
    output = []
    # x_range = list(grange(-2, 2))
    # y_range = list(grange(-2, 2))

    # x_range = list(grange(-0.1, 0.4))
    # y_range = list(grange(0.5, 0.8))

    # x_range = list(grange(0.1, 0.18))
    # y_range = list(grange(0.62, 0.7))

    x_range = list(grange(xmin, xmax))
    y_range = list(grange(ymin, ymax))

    for x, y in ((x, y) for x in x_range for y in y_range):
        output += ['%f %f %i' % (x, y, is_in_set(x, y))]

    # write out output to file.
    with open('output', 'w') as file:
        file.write('\n'.join(output))

    # os.system('gnuplot -p plot2.dem')


# return values between start and stop at the specified granularity
def grange(start, stop=None, gran=granularity):
    if stop == None:
        stop = start
        start = 0
    val = start
    step = f(stop - start, gran)
    while val < stop:
        yield val
        val += step

# the test function
def is_in_set(x, y):
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
        # point /isn't/ in the set. if the magnitude of z ever goes above 2,
        # then we /know/ it's not in the set.
        if i >= maxiter:
            break

    return i


if __name__ == '__main__':
    global xmin, xmax, ymin, ymax

    if len(argv) == 5:
        xmin, xmax = map(f, argv[1:3])
        ymin, ymax = map(f, argv[3:5])
    else:
        xmin, xmax = f(-2), f(2)
        ymin, ymax = f(-2), f(2)

    main()
