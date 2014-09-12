from libc.stdio cimport *

cdef extern from "gmp.h":
    ctypedef unsigned long int mp_bitcnt_t

    ctypedef struct __mpz_struct:
        pass
    ctypedef struct __mpq_struct:
        pass

    ctypedef __mpz_struct mpz_t[1]
    ctypedef __mpz_struct *mpz_ptr
    ctypedef const __mpz_struct *mpz_srcptr

    ctypedef __mpq_struct mpq_t[1]
    ctypedef __mpq_struct *mpq_ptr
    ctypedef const __mpq_struct *mpq_srcptr

    void mpq_abs (mpq_ptr, mpq_srcptr)
    void mpq_add (mpq_ptr, mpq_srcptr, mpq_srcptr)
    void mpq_canonicalize (mpq_ptr)
    void mpq_clear (mpq_ptr)
    void mpq_clears (mpq_ptr, ...)
    int mpq_cmp (mpq_srcptr, mpq_srcptr)
    int mpq_cmp_si (mpq_srcptr, long, unsigned long)
    int mpq_cmp_ui (mpq_srcptr, unsigned long int, unsigned long int)
    void mpq_div (mpq_ptr, mpq_srcptr, mpq_srcptr)
    void mpq_div_2exp (mpq_ptr, mpq_srcptr, mp_bitcnt_t)
    int mpq_equal (mpq_srcptr, mpq_srcptr)
    void mpq_get_num (mpz_ptr, mpq_srcptr)
    void mpq_get_den (mpz_ptr, mpq_srcptr)
    double mpq_get_d (mpq_srcptr)
    char *mpq_get_str (char *, int, mpq_srcptr)
    void mpq_init (mpq_ptr)
    void mpq_inits (mpq_ptr, ...)
    size_t mpq_inp_str (mpq_ptr, FILE *, int)
    void mpq_inv (mpq_ptr, mpq_srcptr)
    void mpq_mul (mpq_ptr, mpq_srcptr, mpq_srcptr)
    void mpq_mul_2exp (mpq_ptr, mpq_srcptr, mp_bitcnt_t)
    void mpq_neg (mpq_ptr, mpq_srcptr)
    size_t mpq_out_str (FILE *, int, mpq_srcptr)
    void mpq_set (mpq_ptr, mpq_srcptr)
    void mpq_set_d (mpq_ptr, double)
    void mpq_set_den (mpq_ptr, mpz_srcptr)
    void mpq_set_f (mpq_ptr, mpf_srcptr)
    void mpq_set_num (mpq_ptr, mpz_srcptr)
    void mpq_set_si (mpq_ptr, signed long int, unsigned long int)
    int mpq_set_str (mpq_ptr, const char *, int)
    void mpq_set_ui (mpq_ptr, unsigned long int, unsigned long int)
    void mpq_set_z (mpq_ptr, mpz_srcptr)
    void mpq_sub (mpq_ptr, mpq_srcptr, mpq_srcptr)
    void mpq_swap (mpq_ptr, mpq_ptr)
