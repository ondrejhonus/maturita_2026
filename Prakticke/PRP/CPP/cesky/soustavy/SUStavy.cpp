//
// Created by student on 25.02.2025.
//

#include "SUStavy.h"
#include <cmath>
#include <algorithm>

const std::string platneCifry = "0123456789ABCDEF";

SUStavy::SUStavy() {
    this->decNum = 0;
}

SUStavy::SUStavy(std::string cislo, int base):decNum(0) {
    setNum(cislo, base);
}

SUStavy::SUStavy(const SUStavy & ss) {
    this->setNum(ss.getNum(2), 2);
}

SUStavy::~SUStavy() {

}

bool SUStavy::setNum(std::string num, int base) {
    if (checkNumInBase(num, base)) {
        this->decNum = toDec(num, base);
        return true;
    }

    return false;
}

std::string SUStavy::getNum(int base) const {
    return toBase(decNum, base);
}

unsigned int SUStavy::toDec(std::string num, int base) const {
    unsigned int dec = 0;
    for (int i = 0; i < num.length(); i++) {
        dec += platneCifry.find(num[i]) * pow(base, num.length() - i - 1);
    }
    return dec;
}

std::string SUStavy::toBase(unsigned int cislo, int base) const {
    std::string vysledek = decNum == 0 ? "0" : "";

    while (cislo > 0) {
        vysledek += platneCifry[cislo % base];
        cislo /= base;
    }

    std::reverse(vysledek.begin(), vysledek.end());

    return vysledek;
}

bool SUStavy::checkBaseInt(int base) const {
    return (base >= 2 && base <= 16);
}

bool SUStavy::checkNumInBase(std::string num, int base) const {
    if (!checkBaseInt(base)) {
        return false;
    }

    for (int i = 0; i < num.length(); i++) {
        int found = platneCifry.find(num[i]);
        //znak nebyl nalezen nebo pozice znaku je vetsi nebo rovna soustave
        if (found == std::string::npos || found >= base) {
            return false;
        }
    }

    return true;
}


std::ostream &operator<<(std::ostream & os, const SUStavy & ss) {
    os << std::endl << "==================================" << std::endl
    << "Cislo v dvojkove soustave: " << ss.getNum(2) << std::endl
    << "Cislo v desitkove soustave: " << ss.getNum(10) << std::endl
    << "Cislo v sestnactkove soustave: " << ss.getNum(16) << std::endl
    << "Cislo v osmickove soustave: " << ss.getNum(8) << std::endl
    << "==================================";
    return os;
}
