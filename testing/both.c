#include <stdio.h>
#include <mpfr.h>
#include <mpc.h>

void main () {
    int i;
    mpfr_t a, b;
    mpc_t c;

    mpfr_init2(a, 64);
    mpfr_init2(b, 64);
    mpc_init2(c, 64);

    mpfr_set_si(a, 5, MPFR_RNDD);
    mpfr_set_si(b, 3, MPFR_RNDD);
    mpc_set_fr_fr(c, a, b, MPC_RNDDD);

    printf("%s\n", mpc_get_str(10, 0, c, MPC_RNDDD));
}
