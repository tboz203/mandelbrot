# {{{
# distutils: language = c++
# vim: fdm=marker
'''
# cython: profile=True
'''

from __future__ import print_function

# python imports
from decimal import Decimal as D
import numpy as np
from matplotlib.colors import hsv_to_rgb

# cython stdlib imports
from libc.stdlib cimport malloc, free

# cython local imports
from mpfr cimport *
from mpc cimport *
# }}}

def process(ranges, gran, maxiter, scale, size): # {{{
    print('starting process')

    x0, y0, xf, yf = [D(n) for n in ranges]
    fmtstr = '%.' + str(size) + 'Rg'
    cdef mpfr_t *x_range = NULL, *y_range = NULL
    cdef long *data
    step = min((xf - x0) / gran, (yf - y0) / gran)

    x_range = granulated_range(x0, xf, step, size)
    y_range = granulated_range(y0, yf, step, size)

    xcount = int((xf - x0) / step)
    ycount = int((yf - y0) / step)

    data = <long*>malloc(sizeof(long)*xcount*ycount)

    for i in range(xcount):
        for j in range(ycount):
            iterations_to_escape(data, x_range, y_range, i, j, (i*ycount)+j,
                    maxiter, size)

    output = np.zeros((ycount, xcount, 3))
    for x in range(xcount):
        for y in range(ycount):
            output[y, x] = to_hsv(data[x*ycount + y], scale)

    return hsv_to_rgb(output)

# }}}

cdef mpfr_t* granulated_range(start, stop, step, size): # {{{
    size = (stop - start) / step
    cdef mpfr_t *out = <mpfr_t*>malloc(sizeof(mpfr_t)*size)
    item = start

    for i in range(size):
        init_set_from_decimal(out[i], item, size)
        item += step

    return out
# }}}

cdef void iterations_to_escape(long *data, mpfr_t *x_range, # {{{
        mpfr_t *y_range, int m, int n, int q, long maxiter, int size):

    cdef long i = 0
    cdef mpc_t z, c

    mpc_init2(z, size)
    mpc_init2(c, size)

    mpc_set_si_si(z, 0, 0, MPC_RNDDD)
    mpc_set_fr_fr(c, x_range[m], y_range[n], MPC_RNDDD)

    while abs_lt_2(z, size):
        mpc_mul(z, z, z, MPC_RNDDD)
        mpc_add(z, z, c, MPC_RNDDD)

        i += 1

        if i >= maxiter:
            i = -1
            break

    mpc_clear(z)
    mpc_clear(c)

    data[q] = i
# }}}

cdef bint abs_lt_2(mpc_ptr n, int size): # {{{
    # cdef mpfr_t absolute
    # cdef int retval
    # mpfr_init2(absolute, size)
    # mpc_abs(absolute, n, MPFR_RNDD)
    # retval = (mpfr_cmp_si(absolute, 2) < 0)
    # mpfr_clear(absolute)
    # return retval

    cdef mpfr_t abs_squared, real_squared, imag_squared
    cdef int retval
    mpfr_inits2(size, abs_squared, real_squared, imag_squared, NULL)
    mpfr_mul(real_squared, mpc_realref(n), mpc_realref(n), MPFR_RNDD)
    mpfr_mul(imag_squared, mpc_imagref(n), mpc_imagref(n), MPFR_RNDD)
    mpfr_add(abs_squared, real_squared, imag_squared, MPFR_RNDD)
    retval = (mpfr_cmp_si(abs_squared, 2) < 0)
    mpfr_clears(abs_squared, real_squared, imag_squared, NULL)
    return retval
# }}}

cdef void init_set_from_decimal(mpfr_t out, dec, int size): # {{{
    mpfr_init2(out, size)
    decstr = str(dec)
    mpfr_set_str(out, decstr, 16, MPFR_RNDD)
# }}}

# cdef from_mpfr(mpfr_t n, fmtstr): # {{{
#     print('starting from_mpfr')
#     cdef char* word
#     mpfr_asprintf(&word, fmtstr, n);
#     return word
# # }}}

cdef to_hsv(double n, int scale): # {{{
    if n == -1:
        return (0.0, 0.0, 0.0)
    else:
        return ((n / scale) % 1.0, 1.0, 1.0)
# }}}
