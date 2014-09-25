#!/usr/bin/env python

import cProfile
import pstats
import sys
import argparse

from process import process

def main():
    args = getargs()
    command = '''\
args = getargs()
process(args.ranges, args.granularity,
    args.maxiter, args.scale, args.size)'''

    if args.profile:
        cProfile.run(command, 'Profile.prof')
        s = pstats.Stats('Profile.prof')
        s.strip_dirs().sort_stats('time').print_stats(5)
    else:
        exec(command)

def getargs():
    parser = argparse.ArgumentParser(description='produce an mandelbrot plot')
    parser.add_argument('-r', '--ranges', type=float, nargs=4,
            default=[-2.0, -2.0, 2.0, 2.0],
            help='what section of the set to calculate.')
    parser.add_argument('-o', '--outfile', default='mandelbrot.png',
            help='what to call the resulting PNG image file.');
    parser.add_argument('-e', '--errfile', default=None,
            help='where to log any errors that result.')
    parser.add_argument('-m', '--maxiter', default=100, type=int,
            help='the number of iterations to run per point.')
    parser.add_argument('-g', '--granularity', default=1000, type=int,
            help='the number of points to calculate per axis.')
    parser.add_argument('-s', '--scale', default=25, type=int,
            help='a scaling value by which to loop colors.')
    parser.add_argument('-i', '--size', default=128, type=int,
            help='the size to use for our floating point type.')
    parser.add_argument('-p', '--profile', action='store_true',
            help='turn on profiling mode.')
    return parser.parse_args()

if __name__ == '__main__':
    main()
