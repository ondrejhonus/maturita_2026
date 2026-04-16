//
// Created by student on 07.02.2024.
//

#ifndef RODNECISLO_RODNE_CISLO_H
#define RODNECISLO_RODNE_CISLO_H

#include <string>
#include <iostream>

class rodneCislo {
private:
    std::string rc;  // Rodné číslo (10 znaků)

    bool jePlatne() const;  // Zkontroluje platnost rodného čísla
    int ziskejRok() const;  // Získá rok narození
    int ziskejMesiac() const;  // Získá měsíc narození
    int ziskejDen() const;  // Získá den narození

public:
    // Konstruktor bez parametrů
    rodneCislo();

    // Konstruktor s parametrem (zadejte rodné číslo)
    rodneCislo(const std::string &rc);

    // Kopírovací konstruktor
    rodneCislo(const rodneCislo &other);

    // Destruktor
    ~rodneCislo();

    // Nastavení rodného čísla
    bool setRC(const std::string &rc);

    // Získání rodného čísla
    std::string getRC() const;

    // Vypisování informací o rodném čísle, datu narození, pohlaví a věku
    void vypisInfo() const;

    // Získání pohlaví
    std::string pohlavi() const;

    // Získání věku osoby
    int vek() const;

    // Přetížení operátoru <<
    friend std::ostream& operator<<(std::ostream &out, const rodneCislo &r);
};

#endif // RODNE_CISLO_H
