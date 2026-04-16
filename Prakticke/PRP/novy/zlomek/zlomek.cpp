//
// Created by student on 24.04.2024.
//

#include "zlomek.h"
#include <iostream>
#include <cmath>

zlomek::zlomek() {
    citatel = 1;
    jmenovatel = 1;
}

zlomek::zlomek(int c, int j) {
    if (j == 0) {
        citatel = 1;
        jmenovatel = 1;
    } else {
        citatel = c;
        jmenovatel = j;
    }
}

zlomek::zlomek(const zlomek& z) {
    citatel = z.citatel;
    jmenovatel = z.jmenovatel;
}

zlomek::~zlomek() {
    // Není nutný specifický destruktor, ale definujeme ho dle zadání
}

int zlomek::getCitatel() const {
    return citatel;
}

int zlomek::getJmenovatel() const {
    return jmenovatel;
}

bool zlomek::setZlomek(int c, int j) {
    if (j == 0) return false;
    citatel = c;
    jmenovatel = j;
    return true;
}

int zlomek::nsd(int a, int b) const {
    a = std::abs(a);
    b = std::abs(b);
    while (b != 0) {
        int tmp = b;
        b = a % b;
        a = tmp;
    }
    return a;
}

void zlomek::vymen(int &a, int &b) {
    int tmp = a;
    a = b;
    b = tmp;
}

void zlomek::prevraceni() {
    if (citatel != 0) {
        vymen(citatel, jmenovatel);
    }
}

bool zlomek::kraceni() {
    int delitel = nsd(citatel, jmenovatel);
    if (delitel > 1) {
        citatel /= delitel;
        jmenovatel /= delitel;
        return true;
    }
    return false;
}

double zlomek::desetinne() const {
    return static_cast<double>(citatel) / jmenovatel;
}

std::ostream& operator<<(std::ostream& os, const zlomek& z) {
    if ((z.citatel < 0 && z.jmenovatel > 0) || (z.jmenovatel < 0 && z.citatel > 0)) {
        os << "-";
    }
    os << std::abs(z.citatel) << "/" << std::abs(z.jmenovatel);
    return os;
}
