#!/usr/bin/env python
# 2013-12-11
# updating

import math
import os
import sys
import subprocess

from fractions import Fraction as f

# the point density
granularity = 1000
# maximum number of iterations (the accuracy of the plot).
maxiter = 70

def main():
    data = []
    data += ["set terminal png size 1000,1000"]
    data += ["set palette model RGB defined (0 '#0000FF', " +
            "1 '#2222FF', 2 '#4444FF', 3 '#6666FF', 6 '#FFFFFF')"]
    data += ["plot '-' using 1:2:3 with points palette"]

    # x_range = list(g_range(-2, 2))
    # y_range = list(g_range(-2, 2))

    x_range = list(g_range(f('-0.5'), f('1.0')))
    y_range = list(g_range(f('-0.5'), f('1.0')))

    # x_range = list(g_range(f('0.0'), f('0.3')))
    # y_range = list(g_range(f('0.5'), f('0.8')))

    # x_range = list(g_range(f('0.1'), f('0.18')))
    # y_range = list(g_range(f('0.62'), f('0.7')))

    # x_range = list(g_range(f('0.13'), f('0.14')))
    # y_range = list(g_range(f('0.665'), f('0.675')))

    # x_range = list(g_range(f('0.134'), f('0.135')))
    # y_range = list(g_range(f('0.670'), f('0.671')))

    for x, y in ((x, y) for x in x_range for y in y_range):
        data += ['%f %f %i' % (x, y, is_in_set(x, y))]


    proc = subprocess.Popen(args=['gnuplot'], stdin=subprocess.PIPE,
            stdout=subprocess.PIPE)

    out, err = proc.communicate('\n'.join(data))

    print('out: {}, err: {}'.format(type(out), type(err)))

    if err:
        with open('err', 'w') as file:
            file.write(err)

    if out:
        with open('mandelbrot.2.png', 'w') as file:
            file.write(out)



# return values between start and stop at the specified granularity
def g_range(start, stop=None, gran=granularity):
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
    main()
