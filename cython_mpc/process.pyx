# distutils: language = c++ # {{{
# vim: fdm=marker
# cython: profile=True

# python imports
from decimal import Decimal as D
import numpy as np

# cython stdlib imports
from libcpp.vector cimport vector
from libcpp.string cimport string
from libc.stdlib cimport malloc, free

# cython local imports
from mpfr cimport *
from mpc cimport *
# }}}

SIZE = 64
FMTSTR = '%.' + str(SIZE) + 'Rg'

def process(ranges, gran, maxiter, scale): # {{{
    x0, y0, xf, yf = ranges
    # step = min((xf - x0) / gran, (yf - y0) / gran)
    # data = np.zeros((

    x_range = granulated_range(x0, xf, gran)
    y_range = granulated_range(y0, yf, gran)

    for y in x_range:
        for x in y_range:
            data[y, x] = iterations_to_escape(x, y, maxiter)

    return data
# }}}

cdef granulated_range(start, stop, granularity): # {{{
    out = []
    item = start

    while item < stop:
        out += [from_decimal(item)]
        item += step

    return out
# }}}

cdef long iterations_to_escape(mpfr_t x, mpfr_t y, long maxiter): # {{{
    cdef long i = 0
    cdef mpc_t z, c

    mpc_init2(z, SIZE)
    mpc_init2(c, SIZE)

    mpc_set_si_si(z, 0, 0, MPC_RNDZZ)
    mpc_set_fr_fr(c, x, y, MPC_RNDZZ)

    while abs_lt_2(z):
        # z = z*z + c
        mpc_mul(z, z, z, MPC_RNDZZ)
        mpc_add(z, z, c, MPC_RNDZZ)

        i += 1

        if i >= maxiter:
            i = -1
            break

    mpc_clear(z)
    mpc_clear(c)
    return i
# }}}

cdef mpfr_t from_decimal(dec): # {{{
    cdef mpfr_t out
    mpfr_init2(out, SIZE)
    decstr = str(dec)
    mpfr_set_str(out, decstr, 16, MPFR_RNDZ)
    return out
# }}}

cdef from_mpfr(mpfr_t n): # {{{
    cdef char* word
    mpfr_asprintf(&word, FMTSTR, n);
    return word
# }}}
