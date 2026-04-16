//
// Created by ucitel on 20.04.2023.
//

#include "datum.h"
#include <ctime>
#include <iomanip>

datum::datum() {
    nastavSystemoveDatum();
}

datum::datum(int d, int m, int r) {
    if (jePlatneDatum(d, m, r)) {
        den = d;
        mesic = m;
        rok = r;
    } else {
        nastavSystemoveDatum();
    }
}

datum::datum(const datum& jiny) {
    den = jiny.den;
    mesic = jiny.mesic;
    rok = jiny.rok;
}

datum::~datum() {}

int datum::getDen() const { return den; }
int datum::getMesic() const { return mesic; }
int datum::getRok() const { return rok; }

bool datum::jePrestupny(int r) const {
    return (r % 4 == 0 && (r % 100 != 0 || r % 400 == 0));
}

int datum::pocetDniVMesici(int m, int r) const {
    switch (m) {
        case 2: return jePrestupny(r) ? 29 : 28;
        case 4: case 6: case 9: case 11: return 30;
        default: return 31;
    }
}

bool datum::jePlatneDatum(int d, int m, int r) const {
    return (r >= 1970 && r <= 2100) &&
           (m >= 1 && m <= 12) &&
           (d >= 1 && d <= pocetDniVMesici(m, r));
}

bool datum::setDatum(int d, int m, int r) {
    if (jePlatneDatum(d, m, r)) {
        den = d;
        mesic = m;
        rok = r;
        return true;
    }
    return false;
}

void datum::nastavSystemoveDatum() {
    den = 14;
    mesic = 4;
    rok = 2024;
}


int datum::pocetDniOd1970() const {
    int dny = 0;
    for (int r = 1970; r < rok; ++r) {
        dny += jePrestupny(r) ? 366 : 365;
    }
    for (int m = 1; m < mesic; ++m) {
        dny += pocetDniVMesici(m, rok);
    }
    dny += den - 1;
    return dny + 1; // Přidáme 1 pro zahrnutí 1. 1. 1970 jako prvního dne
}


int datum::denVTydnu() const {
    // Oprava: posuneme jen o 2 (ne 3), protože dny od 1970 jsou teď o 1 vyšší
    int iso = ((pocetDniOd1970() + 2) % 7 + 1);
    return iso == 0 ? 7 : iso;
}


std::ostream& operator<<(std::ostream& os, const datum& dt) {
    os << dt.getDen() << ". " << dt.getMesic() << ". " << dt.getRok()
       << ", pocet dni od 1. 1. 1970 je " << dt.pocetDniOd1970()
       << ", den v tydnu je " << dt.denVTydnu();
    return os;
}




