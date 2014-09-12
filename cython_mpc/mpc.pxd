from libc.stdio cimport *
from gmp.all cimport *
from mpfr cimport *

cdef extern from "mpc.h":
    ctypedef struct __mpc_struct:
        pass

    int MPC_RNDNN
    int MPC_RNDNU
    int MPC_RNDND
    int MPC_RNDNZ

    int MPC_RNDUN
    int MPC_RNDUU
    int MPC_RNDUD
    int MPC_RNDUZ

    int MPC_RNDDN
    int MPC_RNDDU
    int MPC_RNDDD
    int MPC_RNDDZ

    int MPC_RNDZN
    int MPC_RNDZU
    int MPC_RNDZD
    int MPC_RNDZZ

    ctypedef __mpc_struct mpc_t[1]
    ctypedef __mpc_struct *mpc_ptr
    ctypedef const __mpc_struct *mpc_srcptr

    int  mpc_add       (mpc_ptr, mpc_srcptr, mpc_srcptr, mpc_rnd_t)
    int  mpc_add_fr    (mpc_ptr, mpc_srcptr, mpfr_srcptr, mpc_rnd_t)
    int  mpc_add_si    (mpc_ptr, mpc_srcptr, long int, mpc_rnd_t)
    int  mpc_add_ui    (mpc_ptr, mpc_srcptr, unsigned long int, mpc_rnd_t)
    int  mpc_sub       (mpc_ptr, mpc_srcptr, mpc_srcptr, mpc_rnd_t)
    int  mpc_sub_fr    (mpc_ptr, mpc_srcptr, mpfr_srcptr, mpc_rnd_t)
    int  mpc_fr_sub    (mpc_ptr, mpfr_srcptr, mpc_srcptr, mpc_rnd_t)
    int  mpc_sub_ui    (mpc_ptr, mpc_srcptr, unsigned long int, mpc_rnd_t)
    int  mpc_ui_ui_sub (mpc_ptr, unsigned long int, unsigned long int, mpc_srcptr, mpc_rnd_t)
    int  mpc_mul       (mpc_ptr, mpc_srcptr, mpc_srcptr, mpc_rnd_t)
    int  mpc_mul_fr    (mpc_ptr, mpc_srcptr, mpfr_srcptr, mpc_rnd_t)
    int  mpc_mul_ui    (mpc_ptr, mpc_srcptr, unsigned long int, mpc_rnd_t)
    int  mpc_mul_si    (mpc_ptr, mpc_srcptr, long int, mpc_rnd_t)
    int  mpc_mul_i     (mpc_ptr, mpc_srcptr, int, mpc_rnd_t)
    int  mpc_sqr       (mpc_ptr, mpc_srcptr, mpc_rnd_t)
    int  mpc_div       (mpc_ptr, mpc_srcptr, mpc_srcptr, mpc_rnd_t)
    int  mpc_pow       (mpc_ptr, mpc_srcptr, mpc_srcptr, mpc_rnd_t)
    int  mpc_pow_fr    (mpc_ptr, mpc_srcptr, mpfr_srcptr, mpc_rnd_t)
    int  mpc_pow_ld    (mpc_ptr, mpc_srcptr, long double, mpc_rnd_t)
    int  mpc_pow_d     (mpc_ptr, mpc_srcptr, double, mpc_rnd_t)
    int  mpc_pow_si    (mpc_ptr, mpc_srcptr, long, mpc_rnd_t)
    int  mpc_pow_ui    (mpc_ptr, mpc_srcptr, unsigned long, mpc_rnd_t)
    int  mpc_pow_z     (mpc_ptr, mpc_srcptr, mpz_srcptr, mpc_rnd_t)
    int  mpc_div_fr    (mpc_ptr, mpc_srcptr, mpfr_srcptr, mpc_rnd_t)
    int  mpc_fr_div    (mpc_ptr, mpfr_srcptr, mpc_srcptr, mpc_rnd_t)
    int  mpc_div_ui    (mpc_ptr, mpc_srcptr, unsigned long int, mpc_rnd_t)
    int  mpc_ui_div    (mpc_ptr, unsigned long int, mpc_srcptr, mpc_rnd_t)
    int  mpc_div_2ui   (mpc_ptr, mpc_srcptr, unsigned long int, mpc_rnd_t)
    int  mpc_mul_2ui   (mpc_ptr, mpc_srcptr, unsigned long int, mpc_rnd_t)
    int  mpc_div_2si   (mpc_ptr, mpc_srcptr, long int, mpc_rnd_t)
    int  mpc_mul_2si   (mpc_ptr, mpc_srcptr, long int, mpc_rnd_t)
    int  mpc_conj      (mpc_ptr, mpc_srcptr, mpc_rnd_t)
    int  mpc_neg       (mpc_ptr, mpc_srcptr, mpc_rnd_t)
    int  mpc_norm      (mpfr_ptr, mpc_srcptr, mpfr_rnd_t)
    int  mpc_abs       (mpfr_ptr, mpc_srcptr, mpfr_rnd_t)
    int  mpc_sqrt      (mpc_ptr, mpc_srcptr, mpc_rnd_t)
    int  mpc_set       (mpc_ptr, mpc_srcptr, mpc_rnd_t)
    int  mpc_set_d     (mpc_ptr, double, mpc_rnd_t)
    int  mpc_set_d_d   (mpc_ptr, double, double, mpc_rnd_t)
    int  mpc_set_ld    (mpc_ptr, long double, mpc_rnd_t)
    int  mpc_set_ld_ld (mpc_ptr, long double, long double, mpc_rnd_t)
    int  mpc_set_f     (mpc_ptr, mpf_srcptr, mpc_rnd_t)
    int  mpc_set_f_f   (mpc_ptr, mpf_srcptr, mpf_srcptr, mpc_rnd_t)
    int  mpc_set_fr    (mpc_ptr, mpfr_srcptr, mpc_rnd_t)
    int  mpc_set_fr_fr (mpc_ptr, mpfr_srcptr, mpfr_srcptr, mpc_rnd_t)
    int  mpc_set_q     (mpc_ptr, mpq_srcptr, mpc_rnd_t)
    int  mpc_set_q_q   (mpc_ptr, mpq_srcptr, mpq_srcptr, mpc_rnd_t)
    int  mpc_set_si    (mpc_ptr, long int, mpc_rnd_t)
    int  mpc_set_si_si (mpc_ptr, long int, long int, mpc_rnd_t)
    int  mpc_set_ui    (mpc_ptr, unsigned long int, mpc_rnd_t)
    int  mpc_set_ui_ui (mpc_ptr, unsigned long int, unsigned long int, mpc_rnd_t)
    int  mpc_set_z     (mpc_ptr, mpz_srcptr, mpc_rnd_t)
    int  mpc_set_z_z   (mpc_ptr, mpz_srcptr, mpz_srcptr, mpc_rnd_t)
    void mpc_swap      (mpc_ptr, mpc_ptr)
    int  mpc_fma       (mpc_ptr, mpc_srcptr, mpc_srcptr, mpc_srcptr, mpc_rnd_t)

    void mpc_set_nan   (mpc_ptr)

    int  mpc_real      (mpfr_ptr, mpc_srcptr, mpfr_rnd_t)
    int  mpc_imag      (mpfr_ptr, mpc_srcptr, mpfr_rnd_t)
    int  mpc_arg       (mpfr_ptr, mpc_srcptr, mpfr_rnd_t)
    int  mpc_proj      (mpc_ptr, mpc_srcptr, mpc_rnd_t)
    int  mpc_cmp       (mpc_srcptr, mpc_srcptr)
    int  mpc_cmp_si_si (mpc_srcptr, long int, long int)
    int  mpc_exp       (mpc_ptr, mpc_srcptr, mpc_rnd_t)
    int  mpc_log       (mpc_ptr, mpc_srcptr, mpc_rnd_t)
    int  mpc_log10     (mpc_ptr, mpc_srcptr, mpc_rnd_t)
    int  mpc_sin       (mpc_ptr, mpc_srcptr, mpc_rnd_t)
    int  mpc_cos       (mpc_ptr, mpc_srcptr, mpc_rnd_t)
    int  mpc_sin_cos   (mpc_ptr, mpc_ptr, mpc_srcptr, mpc_rnd_t, mpc_rnd_t)
    int  mpc_tan       (mpc_ptr, mpc_srcptr, mpc_rnd_t)
    int  mpc_sinh      (mpc_ptr, mpc_srcptr, mpc_rnd_t)
    int  mpc_cosh      (mpc_ptr, mpc_srcptr, mpc_rnd_t)
    int  mpc_tanh      (mpc_ptr, mpc_srcptr, mpc_rnd_t)
    int  mpc_asin      (mpc_ptr, mpc_srcptr, mpc_rnd_t)
    int  mpc_acos      (mpc_ptr, mpc_srcptr, mpc_rnd_t)
    int  mpc_atan      (mpc_ptr, mpc_srcptr, mpc_rnd_t)
    int  mpc_asinh     (mpc_ptr, mpc_srcptr, mpc_rnd_t)
    int  mpc_acosh     (mpc_ptr, mpc_srcptr, mpc_rnd_t)
    int  mpc_atanh     (mpc_ptr, mpc_srcptr, mpc_rnd_t)
    void mpc_clear     (mpc_ptr)
    int  mpc_urandom   (mpc_ptr, gmp_randstate_t)
    void mpc_init2     (mpc_ptr, mp_prec_t)
    void mpc_init3     (mpc_ptr, mp_prec_t, mp_prec_t)
    mp_prec_t mpc_get_prec (mpc_srcptr x)
    void mpc_get_prec2 (mp_prec_t *pr, mp_prec_t *pi, mpc_srcptr x)
    void mpc_set_prec  (mpc_ptr, mp_prec_t)
    const char * mpc_get_version ()

    int  mpc_strtoc    (mpc_ptr, const char *, char **, int, mpc_rnd_t)
    int  mpc_set_str   (mpc_ptr, const char *, int, mpc_rnd_t)
    char * mpc_get_str (int, size_t, mpc_srcptr, mpc_rnd_t)
    void mpc_free_str  (char *)

    int mpc_inp_str    (mpc_ptr, FILE *, size_t *, int, mpc_rnd_t)
    size_t mpc_out_str (FILE *, int, size_t, mpc_srcptr, mpc_rnd_t)
