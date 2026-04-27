#include <stdio.h>
#include <math.h>

int prvocislo(int n) {
    int delitel = 2;
    if (n == 1) {
        return 0;
    }
    while (delitel <= sqrt(n)) {
        if (n % delitel == 0) {
            return 0;
        }
        delitel++;
    }
    return 1;
}

int mocnina(int zaklad, int exponent) {
    int vysledek = 1;
    for (int i = 0; i < exponent ; i++) {
        vysledek *= zaklad;
    }
    return vysledek;
}


int main(void) {
    printf("Je cislo 7 prvocislem? %s\n", prvocislo(7) ? "ano" : "ne");
    printf("2 na 3 je: %d", mocnina(2,3));
    return 0;
}