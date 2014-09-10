cdef extern from "stdio.h":
    ctypedef struct FILE

cdef extern from "gmp.h":
    struct mpq_t:
        pass
    struct mpq_bitcnt_t:
        pass

    void mpq_abs (mpq_t, mpq_t)
    void mpq_add (mpq_t, mpq_t, mpq_t)
    void mpq_canonicalize (mpq_t)
    void mpq_clear (mpq_t)
    void mpq_clears (mpq_t, ...)
    int mpq_cmp (mpq_t, mpq_t)
    int _mpq_cmp_si (mpq_t, long, unsigned long)
    int _mpq_cmp_ui (mpq_t, unsigned long int, unsigned long int)
    void mpq_div (mpq_t, mpq_t, mpq_t)
    void mpq_div_2exp (mpq_t, mpq_t, mp_bitcnt_t)
    int mpq_equal (mpq_t, mpq_t)
    void mpq_get_num (mpz_ptr, mpq_t)
    void mpq_get_den (mpz_ptr, mpq_t)
    double mpq_get_d (mpq_t)
    char *mpq_get_str (char *, int, mpq_t)
    void mpq_init (mpq_t)
    void mpq_inits (mpq_t, ...)
    size_t mpq_inp_str (mpq_t, FILE *, int)
    void mpq_inv (mpq_t, mpq_t)
    void mpq_mul (mpq_t, mpq_t, mpq_t)
    void mpq_mul_2exp (mpq_t, mpq_t, mp_bitcnt_t)
    void mpq_neg (mpq_t, mpq_t)
    size_t mpq_out_str (FILE *, int, mpq_t)
    void mpq_set (mpq_t, mpq_t)
    void mpq_set_d (mpq_t, double)
    void mpq_set_den (mpq_t, mpz_srcptr)
    void mpq_set_f (mpq_t, mpf_srcptr)
    void mpq_set_num (mpq_t, mpz_srcptr)
    void mpq_set_si (mpq_t, signed long int, unsigned long int)
    int mpq_set_str (mpq_t, const char *, int)
    void mpq_set_ui (mpq_t, unsigned long int, unsigned long int)
    void mpq_set_z (mpq_t, mpz_srcptr)
    void mpq_sub (mpq_t, mpq_t, mpq_t)
    void mpq_swap (mpq_t, mpq_t)

cdef mpc_t mpc_mult(mpc_t c, mpc_t a, mpc_t b):
    cdef mpq_t x, y, u, v, m, n
    cdef mpc_t d

    x, y = a.real, a.imag
    u, v = b.real, b.imag

    mpq_mul(m, x, u)
    mpq_mul(n, y, v)
    mpq_sub(d.real, m, n)

    mpq_mul(m, x, v)
    mpq_mul(n, y, u)
    mpq_add(d.imag, m, n)

    c.real = d.real
    c.imag = d.imag

