# distutils: language = c++
# cython: profile=True

from libcpp.vector cimport vector
from libcpp.string cimport string

def process(args):
    x_range = granulated_range(args.ranges[0],
            args.ranges[0] + args.ranges[2],
            args.granularity)
    y_range = granulated_range(args.ranges[1],
            args.ranges[1] + args.ranges[2],
            args.granularity)

    return calculate(x_range, y_range, args.maxiter)


cdef list calculate(vector[float] x_range, vector[float] y_range, int maxiter):
    data = []

    for y in y_range:
        row = []
        for x in x_range:
            n = iterations_to_escape(x, y, maxiter)
            row += [n]
        data += [row]

    return data


# return values between start and stop at the specified granularity
cdef vector[float] granulated_range(float start, float stop=0, float gran=1.0):
    '''Like ranges, except you can specify any rational step size'''
    if stop == 0 and start > stop:
        start, stop = stop, start
    cdef float val = start
    cdef float step = (stop - start) / gran
    cdef vector[float] output
    while val < stop:
        output.push_back(val)
        val += step

    return output


# the test function
cdef int iterations_to_escape(float x, float y, int maxiter):
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
            break

    return i
