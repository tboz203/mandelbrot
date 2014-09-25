# {{{
# distutils: language = c++
# vim: fdm=marker
# cython: profile=True

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

    output = np.zeros((ycount, xcount, 3))
    calculate(output, x_range, y_range, xcount, ycount, maxiter, size, scale)

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

cdef void calculate(output, mpfr_t *x_range, mpfr_t *y_range, # {{{
        int xcount, int ycount, long maxiter, int size, int scale):

    cdef long n
    cdef int val
    cdef mpc_t z, c
    cdef mpfr_t abs_squared, real_squared, imag_squared

    mpc_init2(z, size)
    mpc_init2(c, size)
    mpfr_inits2(size, abs_squared, real_squared, imag_squared, NULL)

    for i in range(xcount):
        for j in range(ycount):
            n = 0
            mpc_set_si_si(z, 0, 0, MPC_RNDDD)
            mpc_set_fr_fr(c, x_range[i], y_range[j], MPC_RNDDD)

            while True:
                # is a*a + b*b > c*c ?
                mpfr_mul(real_squared, mpc_realref(z), mpc_realref(z), MPFR_RNDD)
                mpfr_mul(imag_squared, mpc_imagref(z), mpc_imagref(z), MPFR_RNDD)
                mpfr_add(abs_squared, real_squared, imag_squared, MPFR_RNDD)
                if (mpfr_cmp_si(abs_squared, 4) > 0):
                    break

                # z = z*z + c
                mpc_mul(z, z, z, MPC_RNDDD)
                mpc_add(z, z, c, MPC_RNDDD)

                n += 1

                if n >= maxiter:
                    n = -1
                    break

            output[j, i] = to_hsv(n, scale)

    mpc_clear(z)
    mpc_clear(c)
    mpfr_clears(abs_squared, real_squared, imag_squared, NULL)
# }}}

cdef void init_set_from_decimal(mpfr_t out, dec, int size): # {{{
    mpfr_init2(out, size)
    decstr = str(dec)
    mpfr_set_str(out, decstr, 10, MPFR_RNDD)
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
