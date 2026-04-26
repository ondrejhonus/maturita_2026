//
// Created by student on 24.04.2024.
//

#ifndef ZLOMEK_ZLOMEK_H
#define ZLOMEK_ZLOMEK_H

#include <ostream>

class zlomek {
private:
    int citatel;
    int jmenovatel;

    int nsd(int a, int b) const;         // Největší společný dělitel
    void vymen(int &a, int &b);          // Výměna hodnot

public:
    zlomek();                            // Konstruktor bez parametrů
    zlomek(int c, int j);                // Konstruktor s parametry
    zlomek(const zlomek& z);             // Kopírovací konstruktor
    ~zlomek();                           // Destruktor

    int getCitatel() const;
    int getJmenovatel() const;
    bool setZlomek(int c, int j);

    void prevraceni();
    bool kraceni();
    double desetinne() const;

    friend std::ostream& operator<<(std::ostream& os, const zlomek& z);
};

#endif
