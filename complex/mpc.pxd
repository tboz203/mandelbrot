cdef struct mpc_t:
    mpq_t real
    mpq_t imag

cdef mpc_t mpc_mult(mpc_t, mpc_t, mpc_t)
