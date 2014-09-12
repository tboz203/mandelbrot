#include <stdio.h>
#include <mpfr.h>

void main () {
    int i;
    mpfr_exp_t e;
    mpfr_t a, b;

    mpfr_init2(a, 64);
    mpfr_init2(b, 64);

    mpfr_set_si(a, 5, MPFR_RNDD);
    mpfr_set_si(b, 3, MPFR_RNDD);

    for (i = 0; i < 10; i++) {
        mpfr_div(a, a, b, MPFR_RNDZ);
    }

    char *target;
    mpfr_asprintf(&target, "%.32Rg", a);
    printf("%s\n", target);

    mpfr_out_str(stdout, 10, 0, a, MPFR_RNDZ);
    printf("\n");
}
