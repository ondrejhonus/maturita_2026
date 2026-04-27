#include <math.h>
#include <stdio.h>

unsigned int mocnina(int zaklad, int exponent) {
    unsigned int vysledek = 1;
    for (int i = 0; i < exponent; i++) {
        vysledek *= zaklad;
    }
    return vysledek;
}

/* int prvocislo(int number) {
    if (number == 1) {
        return 0; // jednicka neni prvocislo!
    }
    for (int delitel =2; delitel <= sqrt(number);delitel++) {
        if (number % delitel == 0) {
            return 0;
        }
    }
    return 1;
} */
int prvocislo(int number) {
    if (number == 1) {
        return 0; // jednicka neni prvocislo!
    }
    int delitel = 2;
    while (delitel <= sqrt(number)) {
        if (number % delitel == 0) {
            return 0;
        }
        delitel++;
    }
    return 1;
}

int main(void) {
    int zaklad = 10;
    int exponent = 3;
    printf("%d ^ %d = %u\n", zaklad, exponent, mocnina(zaklad, exponent));
    printf("Cislo %d %s prvocislo!", zaklad, prvocislo(zaklad) ? "je" : "neni");
    return 0;
}
