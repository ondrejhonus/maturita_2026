//
// Created by student on 07.02.2024.
//

#include "rodne_cislo.h"
#include <ctime>

#include "rodne_cislo.h"
#include <ctime>

rodne_cislo::rodne_cislo() {
    this->rodneCislo = defaultRC;
}

rodne_cislo::~rodne_cislo() {

}

bool rodne_cislo::setRC(string rc) {
    if (kontrola(rc)) {
        this->rodneCislo = rc;
        return true;
    }
    return false;
}

bool rodne_cislo::kontrola(string rc) const {
    if (rc.size() != 10) {
        return false;
    }
    for (int i = 0; i < rc.size(); i++) {
        if (rc[i] < '0' || rc[i] > '9') {
            return false;
        }
    }
    int zbytekPoCeloDeleni = std::stoi(rc.substr(0, 9)) % 11;
    if (zbytekPoCeloDeleni == std::stoi(rc.substr(9, 1))) {
        return true;
    } else if (zbytekPoCeloDeleni == 10 && std::stoi(rc.substr(9, 1)) == 0) {
        return true;
    }
    return false;
}

rodne_cislo::rodne_cislo(string rc) {
    if (!setRC(rc)) {
        this->rodneCislo = defaultRC;
    }
}

string rodne_cislo::getRC() const {
    return this->rodneCislo;
}

ostream &operator<<(ostream &os, const rodne_cislo &rc) {
    os << "Rodne cislo: " << rc.getRC() << std::endl;
    os << "Narozen: " << rc.datumNarozeni() << std::endl;
    os << "Pohlavi: " << (rc.pohlavi()? "Muz" : "Zena") << std::endl;
    os << "Vek: " << rc.vek() << std::endl;
    return os;
}

rodne_cislo::rodne_cislo(const rodne_cislo &rc3) {
    this->rodneCislo = rc3.getRC();
}

int rodne_cislo::rokNar() const {
    int rok = std::stoi(rodneCislo.substr(0, 2));

    return rok >= 54 ? rok + 1900 : rok + 2000;
}

int rodne_cislo::mesicNar() const {
    int mesic = std::stoi(rodneCislo.substr(2,2));
    return mesic % 50;
}

int rodne_cislo::denNar() const {
    int den = std::stoi(rodneCislo.substr(4,2));
    return den;
}

string rodne_cislo::datumNarozeni() const {
    return std::to_string(this->denNar())+". " +
           std::to_string(this->mesicNar())+". " +
           std::to_string(this->rokNar());
}

bool rodne_cislo::pohlavi() const {

    return !(std::stoi(rodneCislo.substr(2,2)) > 50);
}

int rodne_cislo::vek() const {
    time_t sekundy = time(NULL);
    struct tm *datum = localtime(&sekundy);
    int sysRok = datum->tm_year + 1900;
    int sysMes = datum->tm_mon + 1;
    int sysDen = datum->tm_mday;
    int Vek = sysRok - this->rokNar();
    if (sysMes < this->mesicNar() || (sysMes == this->mesicNar() &&
                                      sysDen < this->denNar())){
        Vek--;
    }
    return Vek;
}

