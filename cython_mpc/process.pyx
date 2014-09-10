# distutils: language = c++
# vim: fdm=marker
# cython: profile=True

from fractions import Fraction

from libcpp.vector cimport vector
from libcpp.string cimport string
from libc.stdlib cimport malloc, free

cdef extern from "stdio.h":
    ctypedef struct FILE

cdef extern from "gmp.h":# {{{
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
    # }}}

def process(x0=-2, y0=-2, dist=4, granularity=1000, maxiter=70):
    # when they come in, x0, y0, and dist are all most likely to be our
    # Fraction type. somewhere we're going to have to convert them, mostlikely
    # by way of strings. granularity can be whatever, but we should cast
    # maxiter to an int to speed up our set membership test

    cdef vector[mpq_ptr] x_range
    cdef vector[mpq_ptr] y_range
    cdef vector[string] output

    x_range = granulated_range(x0, dist, granularity)
    y_range = granulated_range(y0, dist, granularity)

    for x in x_range:
        for y in y_range:
            xstr, ystr = mpq_get_str(NULL, 10, x), mpq_get_str(NULL, 10, y)
            output.push_back('%s %s %s' % (xstr, ystr,
                    iterations_to_escape(x, y, maxiter)))

    return <object>output


cdef vector[mpq_ptr] granulated_range(py_start, py_dist, granularity):#{{{
    # this function should only be called twice, so we can afford to be a
    # little more expensive

    cdef mpq_t start, dist, step
    cdef mpq_ptr item
    cdef vector[mpq_ptr] output

    mpq_inits(start, dist, step, step, NULL)

    from_fraction(start, py_start)
    from_fraction(dist, py_dist)
    mpq_set_si(step, granularity, 1)    # using step as a temp var real quick
    mpq_div(step, dist, step)           # step = dist / granularity

    for i in range(granularity):
        item = <mpq_ptr>malloc(sizeof(mpq_t))
        mpq_init(item)
        mpq_add(item, start, step)
        mpq_set(start, item)
        output.push_back(<mpq_ptr>item)

    return output#}}}


# the number of iterations it takes for the given x,y coordinate to go
# exponential with the mandelbrot function application
cdef int iterations_to_escape(mpq_t x, mpq_t y, int maxiter):

    cdef mpq_t z, zj
    cdef mpq_t c, cj
    cdef int i = 0

    # tmp values
    cdef mpq_t a, b

    mpq_inits(z, zj, c, cj, a, b, NULL);

    mpq_set(c, x)
    mpq_set(cj, y)

    xstr, ystr = mpq_get_str(NULL, 10, x), mpq_get_str(NULL, 10, y)
    print('starting with (%s + %sj)' % (xstr, ystr))

    while abs_lt_2(z, zj):
        # z = z*z + c
        mpq_mul_complex(z, zj, z, zj, z, zj)
        mpq_add_complex(z, zj, z, zj, c, cj)

        zstr, zjstr = mpq_get_str(NULL, 10, z), mpq_get_str(NULL, 10, zj)
        print('    (%s + %sj)' % (zstr, zjstr))

        i += 1

        if i >= maxiter:
            break

    mpq_clears(z, zj, c, cj, a, b, NULL)
    return i

def test_complex_multiplication(pyA, pyAj, pyB, pyBj):#{{{
    cdef mpq_t a, aj, b, bj, n, nj
    mpq_inits(a, aj, b, bj, n, nj, NULL)

    from_fraction(a, pyA)
    from_fraction(aj, pyAj)
    from_fraction(b, pyB)
    from_fraction(bj, pyBj)

    traditional = complex(pyA, pyAj) * complex(pyB, pyBj)

    mpq_mul_complex_a(n, nj, a, aj, b, bj)
    mpq_mul_complex_b(a, aj, a, aj, b, bj)

    A = from_mpq(n) + from_mpq(nj) * 1j
    B = from_mpq(a) + from_mpq(aj) * 1j

    if not (A == B == traditional):
        print(traditional, A, B)#}}}

cdef void from_fraction(mpq_t frac, object py_frac):# {{{

    py_frac = Fraction(py_frac)

    # the string form of a python fraction is a form acceptable for
    # mpq_set_str. this is expensive, but we don't do it but four (three?)
    # times. python fractions are also already canonicalized
    frac_str = str(py_frac)

    mpq_set_str(frac, frac_str, 10)

# }}}

cdef object from_mpq(mpq_t frac): # {{{
    cdef char *frac_str = mpq_get_str(NULL, 10, frac)
    out = Fraction(<object>frac_str)
    return out
# }}}

# --------------- complex rational type helper functions ---------------
# considered abstracting all this out into a complex rational type, but it was
# a lot of work and i'm never going to use any of it again.

cdef void mpq_mul_complex(mpq_t realOut, mpq_t imagOut,# {{{
        mpq_t realA, mpq_t imagA, mpq_t realB, mpq_t imagB):

    mpq_mul_complex_b(realOut, imagOut, realA, imagA, realB, imagB) # }}}

cdef void mpq_mul_complex_a(mpq_t realOut, mpq_t imagOut,# {{{
        mpq_t realA, mpq_t imagA, mpq_t realB, mpq_t imagB):

    cdef mpq_t a, b
    mpq_inits(a, b, NULL)

    # first the real part
    mpq_mul(a, realA, realB)
    mpq_mul(b, imagA, imagB)
    mpq_sub(realOut, a, b)

    # then the imaginary part
    mpq_mul(a, realA, imagB)
    mpq_mul(b, imagA, realB)
    mpq_add(imagOut, a, b)

    # and clear our local vars
    mpq_clears(a, b, NULL) # }}}

cdef void mpq_mul_complex_b(mpq_t realOut, mpq_t imagOut,# {{{
        mpq_t realA, mpq_t imagA, mpq_t realB, mpq_t imagB):

    # alternate version
    cdef mpq_t i, j, k
    mpq_inits(i, j, k, NULL)

    mpq_add(i, realB, imagB)
    mpq_mul(i, i, realA)

    mpq_add(j, realA, imagA)
    mpq_mul(j, j, imagB)

    mpq_sub(k, imagA, realA)
    mpq_mul(k, k, realB)

    mpq_sub(realOut, i, j)
    mpq_add(imagOut, i, k)

    mpq_clears(i, j, k, NULL)

# }}}

cdef void mpq_add_complex(mpq_t realOut, mpq_t imagOut, # {{{
        mpq_t realA, mpq_t imagA, mpq_t realB, mpq_t imagB):

    cdef mpq_t a, b
    mpq_inits(a, b, NULL)

    mpq_add(a, realA, realB)
    mpq_add(b, imagA, imagB)

    mpq_set(realOut, a)
    mpq_set(imagOut, b)

    mpq_clears(a, b, NULL)

# }}}

# more specific to this particular application
cdef bint abs_lt_2(mpq_t real, mpq_t imag): # {{{

    cdef mpq_t a, b
    cdef bint flag

    mpq_inits(a, b, NULL)

    # a^2 + b^2 = c^2

    mpq_mul(a, real, real)
    mpq_mul(b, imag, imag)
    mpq_add(a, a, b)
    flag = mpq_cmp_si(a, 4, 1) < 0

    mpq_clears(a, b, NULL);

    return flag
# }}}
