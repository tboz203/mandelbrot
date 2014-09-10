#!/usr/bin/env python3
# 2013-12-11
# updating
# 2014-08-23
# re-updating

import math
import os
import sys
import subprocess
import argparse

def main():
    granularity = 1000
    # the point density

    args = getargs()

    x_range = granulated_range(args.ranges[0],
            args.ranges[0] + args.ranges[2],
            granularity)
    y_range = granulated_range(args.ranges[1],
            args.ranges[1] + args.ranges[2],
            granularity)

    data = header()
    data += process(x_range, y_range, args.maxiter)
    send_gnuplot(data, args.outfile, args.errfile)

def header():
    data = []
    data += [b"set terminal png size 1000,1000"]
    data += [b"set palette model RGB defined (0 '#0000FF', "
            +b"1 '#2222FF', 2 '#4444FF', 3 '#6666FF', 6 '#FFFFFF')"]
    data += [b"plot '-' using 1:2:3 with points palette"]
    return data


def getargs():
    parser = argparse.ArgumentParser(description='produce an mandelbrot plot')
    parser.add_argument('-r', '--ranges', type=float, nargs=3, 
            default=[-2.0, -2.0, 4.0],
            help='what section of the set to calculate.')
    parser.add_argument('-o', '--outfile', default='mandelbrot.png',
            help='what to call the resulting PNG image file.');
    parser.add_argument('-e', '--errfile', default=None,
            help='where to log any errors that result.')
    parser.add_argument('-i', '--maxiter', default=70, type=int,
            help='the number of iterations to run per point.')
    return parser.parse_args()


def process(x_range, y_range, maxiter):
    data = []
    x_range = list(x_range)
    y_range = list(y_range)

    for x, y in ((x, y) for x in x_range for y in y_range):
        data += [bytes('%f %f %i' % (x, y, is_in_set(x, y, maxiter)), 'utf-8')]

    return data


def send_gnuplot(data, outfile, errfile):
    proc = subprocess.Popen(args=['gnuplot'],
                            stdin=subprocess.PIPE,
                            stdout=subprocess.PIPE)

    out, err = proc.communicate(b'\n'.join(data))

    print('out: {}, err: {}'.format(type(out), type(err)))
    if err:
        with open(errfile, 'wb') as file:
            file.write(err)
    if out:
        with open(outfile, 'wb') as file:
            file.write(out)


# return values between start and stop at the specified granularity
def granulated_range(start, stop=None, gran=1):
    if stop == None:
        stop = start
        start = 0
    val = start
    step = (stop - start) / gran
    while val < stop:
        yield val
        val += step

# the test function
def is_in_set(x, y, maxiter):
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


# the test function
def is_in_set(x, y, maxiter):
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
