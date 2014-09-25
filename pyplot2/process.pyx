# distutils: language = c++
# cython: profile=True

from matplotlib.colors import hsv_to_rgb
import numpy as np

from libcpp.vector cimport vector
from libcpp.string cimport string

def process(ranges, gran, maxiter, scale):
    x0, y0, xf, yf = ranges

    xstep = (xf - x0) / (<double>gran)
    ystep = (yf - y0) / (<double>gran)

    step = min(xstep, ystep)

    x_range = np.arange(x0, xf, xstep)
    y_range = np.arange(y0, yf, ystep)

    return calculate(x_range, y_range, maxiter, scale)


cdef calculate(x_range, y_range, int maxiter, int scale):
    data = np.zeros((len(x_range), len(y_range), 3), dtype=float)
    # data = np.zeros((len(x_range), len(y_range)), dtype=float)

    for i, y in enumerate(y_range):
        for j, x in enumerate(x_range):
            try:
                data[i, j] = to_hsv(iterations_to_escape(x, y, maxiter), scale)
                # data[i, j] = iterations_to_escape(x, y, maxiter)
            except IndexError:
                pass

    return hsv_to_rgb(data)
    # return data


# the test function
cdef int iterations_to_escape(double x, double y, int maxiter):
    # z starts at 0,0j
    cdef complex z = complex(0, 0)
    # c will always be our coordinates
    cdef complex c = complex(x, y)
    # i is the iteration we are on
    cdef int i = 0

    while (z.real*z.real + z.imag*z.imag) < 4:
        # our magic function
        z = z*z + c
        # increment our iteration count
        i += 1
        # if we go over our max iteration count, then we don't know that this
        # point *isn't* in the set. if the magnitude of z ever goes above 2,
        # then we *know* it's not in the set.
        if i >= maxiter:
            return -1
            # break

    return i

cdef to_hsv(double n, int scale):
    if n == -1:
        return (0.0, 0.0, 0.0)
    else:
        return ((n / scale) % 1.0, 1.0, 1.0)
