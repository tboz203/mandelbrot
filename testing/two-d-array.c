#include <stdio.h>
#include <stdlib.h>

void main () {
    long i, j, k;
    long *data;

    data = (long*)malloc(sizeof(long) * 1000 * 1000);

    for (i = 0; i < 1000; i++) {
        for (j = 0; j < 1000; j++) {
            data[(i*1000)+j] = i*j;
        }
    }

    k = 0;
    for (i = 0; i < 1000; i++) {
        for (j = 0; j < 1000; j++) {
            k = data[(i*1000) + j] - k;
            printf("%li\n", k);
        }
    }
}
