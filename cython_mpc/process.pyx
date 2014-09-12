# {{{
# vim: fdm=marker
# cython: profile=True

from __future__ import print_function

# python imports
from decimal import Decimal as D
import numpy as np

# cython local imports
from mpc cimport *
# }}}

SIZE = 64
FMTSTR = '%.' + str(SIZE) + 'Rg'

def process(ranges, gran, maxiter, scale): # {{{
    print('starting process')
    x0, y0, xf, yf = [D(n) for n in ranges]
    step = min((xf - x0) / gran, (yf - y0) / gran)

    x_range = granulated_range(x0, xf, step)
    y_range = granulated_range(y0, yf, step)

    data = np.zeros((len(y_range), len(x_range), 3))

    for i, y in enumerate(x_range):
        for j, x in enumerate(y_range):
            print(i, j)
            data[i, j] = iterations_to_escape(x, y, maxiter)

    return data
# }}}

def granulated_range(start, stop, step): # {{{
    print('starting granulated_range')
    item = start
    out = []

    while item < stop:
        out += [item]
        item += step

    return out
# }}}

cdef long iterations_to_escape(x, y, maxiter): # {{{
    cdef long i = 0
    cdef mpc_t z, c

    init_set_from_decimal_pair(z, D(0), D(0))
    init_set_from_decimal_pair(c, x, y)

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

cdef bint abs_lt_2(mpc_ptr n): # {{{
    return False
# }}}

cdef void init_set_from_decimal_pair(mpc_t out, real, comp): # {{{
    mpc_init2(out, SIZE)
    decstr = '({} + {})'.format(real, comp)
    mpc_set_str(out, decstr, 16, MPC_RNDNN)
# }}}
