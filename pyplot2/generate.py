#!/usr/bin/env python

from __future__ import division, print_function
import argparse
from matplotlib import pyplot as plt
from process import process


class OnMoveCallback(object):
    def __init__(self, args):
        self.args = args

    def __call__(self, event):
        if event.key != 'enter':
            return
        axes = event.canvas.figure.get_axes()[0]
        x0, xf = axes.get_xbound()
        y0, yf = axes.get_ybound()

        data = process((x0, y0, xf, yf), self.args.granularity,
                self.args.maxiter, self.args.scale)

        plt.imshow(data, interpolation='none', extent=(x0, xf, y0, yf), origin='lower')
        plt.show()


def main():
    args = getargs()

    callback = OnMoveCallback(args)
    plt.connect('key_press_event', callback)

    data = process(args.ranges, args.granularity, args.maxiter, args.scale)
    extent = (args.ranges[0], args.ranges[2], args.ranges[3], args.ranges[1])

    plt.imshow(data, interpolation='none', extent=extent, origin='lower')
    plt.gca().invert_yaxis()
    plt.show()


def getargs():
    parser = argparse.ArgumentParser(description='produce an mandelbrot plot')
    parser.add_argument('-r', '--ranges', type=float, nargs=4,
            default=[-2.0, -2.0, 2.0, 2.0],
            help='what section of the set to calculate.')
    parser.add_argument('-m', '--maxiter', default=1000, type=int,
            help='the number of iterations to run per point.')
    parser.add_argument('-g', '--granularity', default=500, type=int,
            help='the number of points to calculate per axis.')
    parser.add_argument('-s', '--scale', default=200, type=int,
            help='a scaling value by which to loop colors')
    return parser.parse_args()


if __name__ == '__main__':
    main()

    # import cProfile, pstats
    # cProfile.run('main()', 'Profile.prof')
    # s = pstats.Stats('Profile.prof')
    # s.strip_dirs().sort_stats('time').print_stats()
