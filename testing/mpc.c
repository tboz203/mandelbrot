#include <stdio.h>
#include <mpc.h>

void main () {
    int i;
    mpc_t a, b;

    mpc_init2(a, 128);
    mpc_init2(b, 128);

    mpc_set_si_si(a, 3, 4, MPC_RNDZZ);
    mpc_set_si_si(b, 2, 2, MPC_RNDZZ);

    for (i = 0; i < 20; i++) {
        mpc_div(a, a, b, MPC_RNDZZ);
    }

    printf("%s\n", mpc_get_str(10, 0, a, MPC_RNDZZ));
}
