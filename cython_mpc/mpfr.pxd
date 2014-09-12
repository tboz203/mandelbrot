from gmp cimport *
from libc.stdio cimport *

cdef extern from "mpfr.h":
    ctypedef enum mpfr_rnd_t:
        pass

    ctypedef long  mpfr_prec_t
    ctypedef unsigned long  mpfr_uprec_t
    ctypedef long mpfr_exp_t
    ctypedef unsigned long mpfr_uexp_t
    ctypedef int mpfr_sign_t

    ctypedef struct __mpfr_struct:
        pass

    ctypedef __mpfr_struct mpfr_t[1]
    ctypedef __mpfr_struct *mpfr_ptr
    ctypedef const __mpfr_struct *mpfr_srcptr

    ctypedef enum mpfr_kind_t:
        pass

    const char * mpfr_get_version ()
    const char * mpfr_get_patches ()
    int mpfr_buildopt_tls_p          ()
    int mpfr_buildopt_decimal_p      ()
    int mpfr_buildopt_gmpinternals_p ()
    const char * mpfr_buildopt_tune_case ()

    mpfr_exp_t mpfr_get_emin     ()
    int        mpfr_set_emin     (mpfr_exp_t)
    mpfr_exp_t mpfr_get_emin_min ()
    mpfr_exp_t mpfr_get_emin_max ()
    mpfr_exp_t mpfr_get_emax     ()
    int        mpfr_set_emax     (mpfr_exp_t)
    mpfr_exp_t mpfr_get_emax_min ()
    mpfr_exp_t mpfr_get_emax_max ()

    void mpfr_set_default_rounding_mode (mpfr_rnd_t)
    mpfr_rnd_t mpfr_get_default_rounding_mode ()
    const char * mpfr_print_rnd_mode (mpfr_rnd_t)

    void mpfr_clear_flags ()
    void mpfr_clear_underflow ()
    void mpfr_clear_overflow ()
    void mpfr_clear_divby0 ()
    void mpfr_clear_nanflag ()
    void mpfr_clear_inexflag ()
    void mpfr_clear_erangeflag ()

    void mpfr_set_underflow ()
    void mpfr_set_overflow ()
    void mpfr_set_divby0 ()
    void mpfr_set_nanflag ()
    void mpfr_set_inexflag ()
    void mpfr_set_erangeflag ()

    int mpfr_underflow_p ()
    int mpfr_overflow_p ()
    int mpfr_divby0_p ()
    int mpfr_nanflag_p ()
    int mpfr_inexflag_p ()
    int mpfr_erangeflag_p ()

    int mpfr_check_range (mpfr_ptr, int, mpfr_rnd_t)

    void mpfr_init2 (mpfr_ptr, mpfr_prec_t)
    void mpfr_init (mpfr_ptr)
    void mpfr_clear (mpfr_ptr)

    void mpfr_inits2 (mpfr_prec_t, mpfr_ptr, ...)
    void mpfr_inits (mpfr_ptr, ...)
    void mpfr_clears (mpfr_ptr, ...)

    int mpfr_prec_round (mpfr_ptr, mpfr_prec_t, mpfr_rnd_t)
    int mpfr_can_round (mpfr_srcptr, mpfr_exp_t, mpfr_rnd_t, mpfr_rnd_t, mpfr_prec_t)
    mpfr_prec_t mpfr_min_prec (mpfr_srcptr)

    mpfr_exp_t mpfr_get_exp (mpfr_srcptr)
    int mpfr_set_exp (mpfr_ptr, mpfr_exp_t)
    mpfr_prec_t mpfr_get_prec (mpfr_srcptr)
    void mpfr_set_prec (mpfr_ptr, mpfr_prec_t)
    void mpfr_set_prec_raw (mpfr_ptr, mpfr_prec_t)
    void mpfr_set_default_prec (mpfr_prec_t)
    mpfr_prec_t mpfr_get_default_prec ()

    int mpfr_set_d (mpfr_ptr, double, mpfr_rnd_t)
    int mpfr_set_flt (mpfr_ptr, float, mpfr_rnd_t)
    int mpfr_set_ld (mpfr_ptr, long double, mpfr_rnd_t)
    int mpfr_set_z (mpfr_ptr, mpz_srcptr, mpfr_rnd_t)
    int mpfr_set_z_2exp (mpfr_ptr, mpz_srcptr, mpfr_exp_t, mpfr_rnd_t)
    void mpfr_set_nan (mpfr_ptr)
    void mpfr_set_inf (mpfr_ptr, int)
    void mpfr_set_zero (mpfr_ptr, int)
    int mpfr_set_f (mpfr_ptr, mpf_srcptr, mpfr_rnd_t)
    int mpfr_get_f (mpf_ptr, mpfr_srcptr, mpfr_rnd_t)
    int mpfr_set_si (mpfr_ptr, long, mpfr_rnd_t)
    int mpfr_set_ui (mpfr_ptr, unsigned long, mpfr_rnd_t)
    int mpfr_set_si_2exp (mpfr_ptr, long, mpfr_exp_t, mpfr_rnd_t)
    int mpfr_set_ui_2exp (mpfr_ptr,unsigned long,mpfr_exp_t,mpfr_rnd_t)
    int mpfr_set_q (mpfr_ptr, mpq_srcptr, mpfr_rnd_t)
    int mpfr_set_str (mpfr_ptr, const char *, int, mpfr_rnd_t)
    int mpfr_init_set_str (mpfr_ptr, const char *, int, mpfr_rnd_t)
    int mpfr_set4 (mpfr_ptr, mpfr_srcptr, mpfr_rnd_t, int)
    int mpfr_abs (mpfr_ptr, mpfr_srcptr, mpfr_rnd_t)
    int mpfr_set (mpfr_ptr, mpfr_srcptr, mpfr_rnd_t)
    int mpfr_neg (mpfr_ptr, mpfr_srcptr, mpfr_rnd_t)
    int mpfr_signbit (mpfr_srcptr)
    int mpfr_setsign (mpfr_ptr, mpfr_srcptr, int, mpfr_rnd_t)
    int mpfr_copysign (mpfr_ptr, mpfr_srcptr, mpfr_srcptr, mpfr_rnd_t)

    mpfr_exp_t mpfr_get_z_2exp (mpz_ptr, mpfr_srcptr)
    float mpfr_get_flt (mpfr_srcptr, mpfr_rnd_t)
    double mpfr_get_d (mpfr_srcptr, mpfr_rnd_t)
    long double mpfr_get_ld (mpfr_srcptr, mpfr_rnd_t)
    double mpfr_get_d1 (mpfr_srcptr)
    double mpfr_get_d_2exp (long*, mpfr_srcptr, mpfr_rnd_t)
    long double mpfr_get_ld_2exp (long*, mpfr_srcptr, mpfr_rnd_t)
    int mpfr_frexp (mpfr_exp_t*, mpfr_ptr, mpfr_srcptr, mpfr_rnd_t)
    long mpfr_get_si (mpfr_srcptr, mpfr_rnd_t)
    unsigned long mpfr_get_ui (mpfr_srcptr, mpfr_rnd_t)
    char*mpfr_get_str (char*, mpfr_exp_t*, int, size_t, mpfr_srcptr, mpfr_rnd_t)
    int mpfr_get_z (mpz_ptr z, mpfr_srcptr f, mpfr_rnd_t)

    void mpfr_free_str (char *)

    int mpfr_urandom (mpfr_ptr, gmp_randstate_t, mpfr_rnd_t)
    int mpfr_grandom (mpfr_ptr, mpfr_ptr, gmp_randstate_t, mpfr_rnd_t)
    int mpfr_urandomb (mpfr_ptr, gmp_randstate_t)

    void mpfr_nextabove (mpfr_ptr)
    void mpfr_nextbelow (mpfr_ptr)
    void mpfr_nexttoward (mpfr_ptr, mpfr_srcptr)

    int mpfr_printf (const char*, ...)
    int mpfr_asprintf (char**, const char*, ...)
    int mpfr_sprintf (char*, const char*, ...)
    int mpfr_snprintf (char*, size_t, const char*, ...)

    int mpfr_pow (mpfr_ptr, mpfr_srcptr, mpfr_srcptr, mpfr_rnd_t)
    int mpfr_pow_si (mpfr_ptr, mpfr_srcptr, long int, mpfr_rnd_t)
    int mpfr_pow_ui (mpfr_ptr, mpfr_srcptr, unsigned long int, mpfr_rnd_t)
    int mpfr_ui_pow_ui (mpfr_ptr, unsigned long int, unsigned long int, mpfr_rnd_t)
    int mpfr_ui_pow (mpfr_ptr, unsigned long int, mpfr_srcptr, mpfr_rnd_t)
    int mpfr_pow_z (mpfr_ptr, mpfr_srcptr, mpz_srcptr, mpfr_rnd_t)

    int mpfr_sqrt (mpfr_ptr, mpfr_srcptr, mpfr_rnd_t)
    int mpfr_sqrt_ui (mpfr_ptr, unsigned long, mpfr_rnd_t)
    int mpfr_rec_sqrt (mpfr_ptr, mpfr_srcptr, mpfr_rnd_t)

    int mpfr_add (mpfr_ptr, mpfr_srcptr, mpfr_srcptr, mpfr_rnd_t)
    int mpfr_sub (mpfr_ptr, mpfr_srcptr, mpfr_srcptr, mpfr_rnd_t)
    int mpfr_mul (mpfr_ptr, mpfr_srcptr, mpfr_srcptr, mpfr_rnd_t)
    int mpfr_div (mpfr_ptr, mpfr_srcptr, mpfr_srcptr, mpfr_rnd_t)

    int mpfr_add_ui (mpfr_ptr, mpfr_srcptr, unsigned long, mpfr_rnd_t)
    int mpfr_sub_ui (mpfr_ptr, mpfr_srcptr, unsigned long, mpfr_rnd_t)
    int mpfr_ui_sub (mpfr_ptr, unsigned long, mpfr_srcptr, mpfr_rnd_t)
    int mpfr_mul_ui (mpfr_ptr, mpfr_srcptr, unsigned long, mpfr_rnd_t)
    int mpfr_div_ui (mpfr_ptr, mpfr_srcptr, unsigned long, mpfr_rnd_t)
    int mpfr_ui_div (mpfr_ptr, unsigned long, mpfr_srcptr, mpfr_rnd_t)

    int mpfr_add_si (mpfr_ptr, mpfr_srcptr, long int, mpfr_rnd_t)
    int mpfr_sub_si (mpfr_ptr, mpfr_srcptr, long int, mpfr_rnd_t)
    int mpfr_si_sub (mpfr_ptr, long int, mpfr_srcptr, mpfr_rnd_t)
    int mpfr_mul_si (mpfr_ptr, mpfr_srcptr, long int, mpfr_rnd_t)
    int mpfr_div_si (mpfr_ptr, mpfr_srcptr, long int, mpfr_rnd_t)
    int mpfr_si_div (mpfr_ptr, long int, mpfr_srcptr, mpfr_rnd_t)

    int mpfr_add_d (mpfr_ptr, mpfr_srcptr, double, mpfr_rnd_t)
    int mpfr_sub_d (mpfr_ptr, mpfr_srcptr, double, mpfr_rnd_t)
    int mpfr_d_sub (mpfr_ptr, double, mpfr_srcptr, mpfr_rnd_t)
    int mpfr_mul_d (mpfr_ptr, mpfr_srcptr, double, mpfr_rnd_t)
    int mpfr_div_d (mpfr_ptr, mpfr_srcptr, double, mpfr_rnd_t)
    int mpfr_d_div (mpfr_ptr, double, mpfr_srcptr, mpfr_rnd_t)

    int mpfr_sqr (mpfr_ptr, mpfr_srcptr,mpfr_rnd_t)

    int mpfr_const_pi (mpfr_ptr, mpfr_rnd_t)
    int mpfr_const_log2 (mpfr_ptr, mpfr_rnd_t)
    int mpfr_const_euler (mpfr_ptr, mpfr_rnd_t)
    int mpfr_const_catalan (mpfr_ptr, mpfr_rnd_t)

    int mpfr_agm (mpfr_ptr, mpfr_srcptr, mpfr_srcptr, mpfr_rnd_t)

    int mpfr_log (mpfr_ptr, mpfr_srcptr,mpfr_rnd_t)
    int mpfr_log2 (mpfr_ptr,mpfr_srcptr,mpfr_rnd_t)
    int mpfr_log10 (mpfr_ptr, mpfr_srcptr, mpfr_rnd_t)
    int mpfr_log1p (mpfr_ptr, mpfr_srcptr, mpfr_rnd_t)

    int mpfr_exp (mpfr_ptr, mpfr_srcptr,mpfr_rnd_t)
    int mpfr_exp2 (mpfr_ptr,mpfr_srcptr,mpfr_rnd_t)
    int mpfr_exp10 (mpfr_ptr, mpfr_srcptr, mpfr_rnd_t)
    int mpfr_expm1 (mpfr_ptr, mpfr_srcptr, mpfr_rnd_t)
    int mpfr_eint (mpfr_ptr,mpfr_srcptr,mpfr_rnd_t)
    int mpfr_li2 (mpfr_ptr,mpfr_srcptr,mpfr_rnd_t)

    int mpfr_cmp  (mpfr_srcptr, mpfr_srcptr)
    int mpfr_cmp3 (mpfr_srcptr, mpfr_srcptr, int)
    int mpfr_cmp_d (mpfr_srcptr, double)
    int mpfr_cmp_ld (mpfr_srcptr, long double)
    int mpfr_cmpabs (mpfr_srcptr, mpfr_srcptr)
    int mpfr_cmp_ui (mpfr_srcptr, unsigned long)
    int mpfr_cmp_si (mpfr_srcptr, long)
    int mpfr_cmp_ui_2exp (mpfr_srcptr, unsigned long, mpfr_exp_t)
    int mpfr_cmp_si_2exp (mpfr_srcptr, long, mpfr_exp_t)
    void mpfr_reldiff (mpfr_ptr, mpfr_srcptr, mpfr_srcptr, mpfr_rnd_t)
    int mpfr_eq (mpfr_srcptr, mpfr_srcptr, unsigned long)
    int mpfr_sgn (mpfr_srcptr)

    int mpfr_mul_2exp (mpfr_ptr, mpfr_srcptr, unsigned long, mpfr_rnd_t)
    int mpfr_div_2exp (mpfr_ptr, mpfr_srcptr, unsigned long, mpfr_rnd_t)
    int mpfr_mul_2ui (mpfr_ptr, mpfr_srcptr, unsigned long, mpfr_rnd_t)
    int mpfr_div_2ui (mpfr_ptr, mpfr_srcptr, unsigned long, mpfr_rnd_t)
    int mpfr_mul_2si (mpfr_ptr, mpfr_srcptr, long, mpfr_rnd_t)
    int mpfr_div_2si (mpfr_ptr, mpfr_srcptr, long, mpfr_rnd_t)

    int mpfr_rint (mpfr_ptr,mpfr_srcptr, mpfr_rnd_t)
    int mpfr_round (mpfr_ptr, mpfr_srcptr)
    int mpfr_trunc (mpfr_ptr, mpfr_srcptr)
    int mpfr_ceil (mpfr_ptr, mpfr_srcptr)
    int mpfr_floor (mpfr_ptr, mpfr_srcptr)
    int mpfr_rint_round (mpfr_ptr, mpfr_srcptr, mpfr_rnd_t)
    int mpfr_rint_trunc (mpfr_ptr, mpfr_srcptr, mpfr_rnd_t)
    int mpfr_rint_ceil (mpfr_ptr, mpfr_srcptr, mpfr_rnd_t)
    int mpfr_rint_floor (mpfr_ptr, mpfr_srcptr, mpfr_rnd_t)
    int mpfr_frac (mpfr_ptr,mpfr_srcptr,mpfr_rnd_t)
    int mpfr_modf (mpfr_ptr, mpfr_ptr, mpfr_srcptr, mpfr_rnd_t)
    int mpfr_remquo (mpfr_ptr, long*, mpfr_srcptr, mpfr_srcptr, mpfr_rnd_t)
    int mpfr_remainder (mpfr_ptr, mpfr_srcptr, mpfr_srcptr, mpfr_rnd_t)
    int mpfr_fmod (mpfr_ptr, mpfr_srcptr, mpfr_srcptr, mpfr_rnd_t)

    int mpfr_fits_ulong_p (mpfr_srcptr, mpfr_rnd_t)
    int mpfr_fits_slong_p (mpfr_srcptr, mpfr_rnd_t)
    int mpfr_fits_uint_p (mpfr_srcptr, mpfr_rnd_t)
    int mpfr_fits_sint_p (mpfr_srcptr, mpfr_rnd_t)
    int mpfr_fits_ushort_p (mpfr_srcptr, mpfr_rnd_t)
    int mpfr_fits_sshort_p (mpfr_srcptr, mpfr_rnd_t)
    int mpfr_fits_uintmax_p (mpfr_srcptr,mpfr_rnd_t)
    int mpfr_fits_intmax_p (mpfr_srcptr, mpfr_rnd_t)

    void mpfr_extract (mpz_ptr, mpfr_srcptr, unsigned int)
    void mpfr_swap (mpfr_ptr, mpfr_ptr)
    void mpfr_dump (mpfr_srcptr)

    int mpfr_nan_p (mpfr_srcptr)
    int mpfr_inf_p (mpfr_srcptr)
    int mpfr_number_p (mpfr_srcptr)
    int mpfr_integer_p (mpfr_srcptr)
    int mpfr_zero_p (mpfr_srcptr)
    int mpfr_regular_p (mpfr_srcptr)

    int mpfr_greater_p (mpfr_srcptr, mpfr_srcptr)
    int mpfr_greaterequal_p (mpfr_srcptr, mpfr_srcptr)
    int mpfr_less_p (mpfr_srcptr, mpfr_srcptr)
    int mpfr_lessequal_p (mpfr_srcptr, mpfr_srcptr)
    int mpfr_lessgreater_p (mpfr_srcptr,mpfr_srcptr)
    int mpfr_equal_p (mpfr_srcptr, mpfr_srcptr)
    int mpfr_unordered_p (mpfr_srcptr, mpfr_srcptr)

    int mpfr_atanh (mpfr_ptr,mpfr_srcptr,mpfr_rnd_t)
    int mpfr_acosh (mpfr_ptr,mpfr_srcptr,mpfr_rnd_t)
    int mpfr_asinh (mpfr_ptr,mpfr_srcptr,mpfr_rnd_t)
    int mpfr_cosh (mpfr_ptr,mpfr_srcptr, mpfr_rnd_t)
    int mpfr_sinh (mpfr_ptr,mpfr_srcptr, mpfr_rnd_t)
    int mpfr_tanh (mpfr_ptr,mpfr_srcptr, mpfr_rnd_t)
    int mpfr_sinh_cosh (mpfr_ptr, mpfr_ptr, mpfr_srcptr, mpfr_rnd_t)

    int mpfr_sech (mpfr_ptr, mpfr_srcptr,mpfr_rnd_t)
    int mpfr_csch (mpfr_ptr, mpfr_srcptr,mpfr_rnd_t)
    int mpfr_coth (mpfr_ptr, mpfr_srcptr,mpfr_rnd_t)

    int mpfr_acos (mpfr_ptr,mpfr_srcptr,mpfr_rnd_t)
    int mpfr_asin (mpfr_ptr,mpfr_srcptr,mpfr_rnd_t)
    int mpfr_atan (mpfr_ptr,mpfr_srcptr,mpfr_rnd_t)
    int mpfr_sin (mpfr_ptr, mpfr_srcptr,mpfr_rnd_t)
    int mpfr_sin_cos (mpfr_ptr, mpfr_ptr, mpfr_srcptr, mpfr_rnd_t)
    int mpfr_cos (mpfr_ptr, mpfr_srcptr,mpfr_rnd_t)
    int mpfr_tan (mpfr_ptr, mpfr_srcptr,mpfr_rnd_t)
    int mpfr_atan2 (mpfr_ptr,mpfr_srcptr,mpfr_srcptr, mpfr_rnd_t)
    int mpfr_sec (mpfr_ptr, mpfr_srcptr,mpfr_rnd_t)
    int mpfr_csc (mpfr_ptr, mpfr_srcptr,mpfr_rnd_t)
    int mpfr_cot (mpfr_ptr, mpfr_srcptr,mpfr_rnd_t)

    int mpfr_hypot (mpfr_ptr, mpfr_srcptr, mpfr_srcptr, mpfr_rnd_t)
    int mpfr_erf (mpfr_ptr, mpfr_srcptr,mpfr_rnd_t)
    int mpfr_erfc (mpfr_ptr, mpfr_srcptr,mpfr_rnd_t)
    int mpfr_cbrt (mpfr_ptr,mpfr_srcptr,mpfr_rnd_t)
    int mpfr_root (mpfr_ptr,mpfr_srcptr,unsigned long,mpfr_rnd_t)
    int mpfr_gamma (mpfr_ptr,mpfr_srcptr,mpfr_rnd_t)
    int mpfr_lngamma (mpfr_ptr,mpfr_srcptr,mpfr_rnd_t)
    int mpfr_lgamma (mpfr_ptr,int*,mpfr_srcptr,mpfr_rnd_t)
    int mpfr_digamma (mpfr_ptr,mpfr_srcptr,mpfr_rnd_t)
    int mpfr_zeta (mpfr_ptr,mpfr_srcptr,mpfr_rnd_t)
    int mpfr_zeta_ui (mpfr_ptr,unsigned long,mpfr_rnd_t)
    int mpfr_fac_ui (mpfr_ptr, unsigned long int, mpfr_rnd_t)
    int mpfr_j0 (mpfr_ptr, mpfr_srcptr, mpfr_rnd_t)
    int mpfr_j1 (mpfr_ptr, mpfr_srcptr, mpfr_rnd_t)
    int mpfr_jn (mpfr_ptr, long, mpfr_srcptr, mpfr_rnd_t)
    int mpfr_y0 (mpfr_ptr, mpfr_srcptr, mpfr_rnd_t)
    int mpfr_y1 (mpfr_ptr, mpfr_srcptr, mpfr_rnd_t)
    int mpfr_yn (mpfr_ptr, long, mpfr_srcptr, mpfr_rnd_t)

    int mpfr_ai (mpfr_ptr, mpfr_srcptr, mpfr_rnd_t)

    int mpfr_min (mpfr_ptr, mpfr_srcptr, mpfr_srcptr, mpfr_rnd_t)
    int mpfr_max (mpfr_ptr, mpfr_srcptr, mpfr_srcptr, mpfr_rnd_t)
    int mpfr_dim (mpfr_ptr, mpfr_srcptr, mpfr_srcptr, mpfr_rnd_t)

    int mpfr_mul_z (mpfr_ptr, mpfr_srcptr, mpz_srcptr, mpfr_rnd_t)
    int mpfr_div_z (mpfr_ptr, mpfr_srcptr, mpz_srcptr, mpfr_rnd_t)
    int mpfr_add_z (mpfr_ptr, mpfr_srcptr, mpz_srcptr, mpfr_rnd_t)
    int mpfr_sub_z (mpfr_ptr, mpfr_srcptr, mpz_srcptr, mpfr_rnd_t)
    int mpfr_z_sub (mpfr_ptr, mpz_srcptr, mpfr_srcptr, mpfr_rnd_t)
    int mpfr_cmp_z (mpfr_srcptr, mpz_srcptr)

    int mpfr_mul_q (mpfr_ptr, mpfr_srcptr, mpq_srcptr, mpfr_rnd_t)
    int mpfr_div_q (mpfr_ptr, mpfr_srcptr, mpq_srcptr, mpfr_rnd_t)
    int mpfr_add_q (mpfr_ptr, mpfr_srcptr, mpq_srcptr, mpfr_rnd_t)
    int mpfr_sub_q (mpfr_ptr, mpfr_srcptr, mpq_srcptr, mpfr_rnd_t)
    int mpfr_cmp_q (mpfr_srcptr, mpq_srcptr)

    int mpfr_cmp_f (mpfr_srcptr, mpf_srcptr)

    int mpfr_fma (mpfr_ptr, mpfr_srcptr, mpfr_srcptr, mpfr_srcptr, mpfr_rnd_t)
    int mpfr_fms (mpfr_ptr, mpfr_srcptr, mpfr_srcptr, mpfr_srcptr, mpfr_rnd_t)
    int mpfr_sum (mpfr_ptr, mpfr_ptr *const, unsigned long, mpfr_rnd_t)

    void mpfr_free_cache ()

    int  mpfr_subnormalize (mpfr_ptr, int, mpfr_rnd_t)

    int  mpfr_strtofr (mpfr_ptr, const char *, char **, int, mpfr_rnd_t)

    size_t mpfr_custom_get_size   (mpfr_prec_t)
    void   mpfr_custom_init    (void *, mpfr_prec_t)
    void * mpfr_custom_get_significand (mpfr_srcptr)
    mpfr_exp_t mpfr_custom_get_exp  (mpfr_srcptr)
    void   mpfr_custom_move       (mpfr_ptr, void *)
    void   mpfr_custom_init_set   (mpfr_ptr, int, mpfr_exp_t, mpfr_prec_t, void *)
    int    mpfr_custom_get_kind   (mpfr_srcptr)
