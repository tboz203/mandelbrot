#!/usr/bin/env python

from __future__ import division, print_function

import argparse
from matplotlib import pyplot
from pprint import pprint

from process import process


def main():
    args = getargs()
    print('processing')
    data = process(args)
    print('plotting')
    plot(data, args)


def plot(data, args):
    extent = (args.ranges[0], args.ranges[0] + args.ranges[2],
              args.ranges[1] + args.ranges[2], args.ranges[1])
    pyplot.imshow(data, interpolation='none', extent=extent)
    pyplot.gca().invert_yaxis()
    pyplot.show()


def getargs():
    parser = argparse.ArgumentParser(description='produce an mandelbrot plot')
    parser.add_argument('-r', '--ranges', type=float, nargs=3,
            default=[-2.0, -2.0, 4.0],
            help='what section of the set to calculate.')
    parser.add_argument('-m', '--maxiter', default=70, type=int,
            help='the number of iterations to run per point.')
    parser.add_argument('-g', '--granularity', default=1000, type=int,
            help='the number of points to calculate across each axis.')
    return parser.parse_args()


if __name__ == '__main__':
    main()

    # import cProfile, pstats
    # cProfile.run('main()', 'Profile.prof')
    # s = pstats.Stats('Profile.prof')
    # s.strip_dirs().sort_stats('time').print_stats()
