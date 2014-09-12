# {{{
# distutils: language = c++
# vim: fdm=marker
# cython: profile=True

from __future__ import print_function

# python imports
from decimal import Decimal as D
import numpy as np

# cython stdlib imports
from libcpp.vector cimport vector
from libc.stdlib cimport malloc, free

# cython local imports
from mpfr cimport *
from mpc cimport *
# }}}

SIZE = 64
FMTSTR = '%.' + str(SIZE) + 'Rg'

def process(ranges, gran, maxiter, scale): # {{{
    print('starting process')
    x0, y0, xf, yf = [D(n) for n in ranges]
    cdef vector[mpfr_ptr] x_range, y_range
    step = min((xf - x0) / gran, (yf - y0) / gran)

    x_range = granulated_range(x0, xf, step)
    y_range = granulated_range(y0, yf, step)

    data = np.zeros((y_range.size(), x_range.size(), 3))

    i = 0
    for y in x_range:
        j = 0
        for x in y_range:
            print(i, j)
            data[i, j] = iterations_to_escape(x, y, maxiter)
            j += 1
        i += 1

    return data
# }}}

cdef vector[mpfr_ptr] granulated_range(start, stop, step): # {{{
    print('starting granulated_range')
    print(start, stop, step)
    cdef vector[mpfr_ptr] out
    item = start

    while item < stop:
        print(item)
        out.push_back(from_decimal(item))
        item += step

    return out
# }}}

cdef long iterations_to_escape(mpfr_ptr x, mpfr_ptr y, long maxiter): # {{{
    print('starting iterations_to_escape')
    cdef long i = 0
    cdef mpc_t z, c

    mpc_init2(z, SIZE)
    mpc_init2(c, SIZE)

    print('initialized')

    mpc_set_si_si(z, 0, 0, MPC_RNDZZ)
    print('first set')
    mpc_set_fr_fr(c, x, y, MPC_RNDZZ)

    print('set')

    while abs_lt_2(z):
        print('looping')
        # z = z*z + c
        mpc_mul(z, z, z, MPC_RNDZZ)
        mpc_add(z, z, c, MPC_RNDZZ)

        i += 1

        if i >= maxiter:
            i = -1
            break

    print('clearing')
    mpc_clear(z)
    mpc_clear(c)
    print('exiting iterations_to_escape')
    return i
# }}}

cdef bint abs_lt_2(mpc_ptr n): # {{{
    print('starting abs_lt_2')
    return False
# }}}

cdef mpfr_ptr from_decimal(dec): # {{{
    print('starting from_decimal')
    print('    ', dec)
    cdef mpfr_t out
    mpfr_init2(out, SIZE)

    print('initialized')
    decstr = str(dec)
    print('string got')
    mpfr_set_str(out, decstr, 16, MPFR_RNDZ)
    print('value set')
    return <mpfr_ptr>out
# }}}

cdef from_mpfr(mpfr_ptr n): # {{{
    print('starting from_mpfr')
    cdef char* word
    mpfr_asprintf(&word, FMTSTR, n);
    return word
# }}}
