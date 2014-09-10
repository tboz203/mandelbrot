#!/usr/bin/env python
# 2013-12-11
# updating
# 2014-08-23
# re-updating

import math
import os
import sys
import subprocess
import argparse

from process import process

def main():
    args = getargs()

    data = header() + process(args)

    send_gnuplot(data, args.outfile, args.errfile)

def header():
    data = []
    data += ["set terminal png size 1000,1000"]
    data += ["set palette model RGB defined (0 '#0000FF', "
            +"1 '#2222FF', 2 '#4444FF', 3 '#6666FF', 6 '#FFFFFF')"]
    data += ["plot '-' using 1:2:3 with points palette"]
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
    parser.add_argument('-m', '--maxiter', default=70, type=int,
            help='the number of iterations to run per point.')
    parser.add_argument('-g', '--granularity', default=1000, type=int,
            help='the number of points to calculate across each axis.')
    return parser.parse_args()


def send_gnuplot(data, outfile, errfile):
    proc = subprocess.Popen(args=['gnuplot'],
                            stdin=subprocess.PIPE,
                            stdout=subprocess.PIPE)

    out, err = proc.communicate('\n'.join(data))

    print('out: {}, err: {}'.format(type(out), type(err)))
    if err:
        with open(errfile, 'wb') as file:
            file.write(err)
    if out:
        with open(outfile, 'wb') as file:
            file.write(out)


if __name__ == '__main__':
    main()

    # import cProfile, pstats
    # cProfile.run('main()', 'Profile.prof')
    # s = pstats.Stats('Profile.prof')
    # s.strip_dirs().sort_stats('time').print_stats()
