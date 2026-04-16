//
// Created by ucitel on 20.04.2023.
//

#ifndef DATUM_DATUM_H
#define DATUM_DATUM_H

#include <iostream>
#include <string>

class datum {
private:
    int den;
    int mesic;
    int rok;

    bool jePrestupny(int rok) const;
    int pocetDniVMesici(int mesic, int rok) const;
    bool jePlatneDatum(int d, int m, int r) const;
    void nastavSystemoveDatum();

public:
    datum(); // konstruktor bez parametrů
    datum(int d, int m, int r); // konstruktor s parametry
    datum(const datum& jiny); // kopírovací konstruktor
    ~datum(); // destruktor

    int getDen() const;
    int getMesic() const;
    int getRok() const;

    bool setDatum(int d, int m, int r);

    int pocetDniOd1970() const;
    int denVTydnu() const;

    friend std::ostream& operator<<(std::ostream& os, const datum& dt);
};

#endif //DATUM_DATUM_H
