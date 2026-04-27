//
// Created by hanar on 10.04.2024.
//

#include "Obdelnik.h"

#include <cmath>

// implementace metod alias definice funkcí

/* výchozí konstruktor nastaví hodnoty stran na platné
 hodnoty - a = 1, b = 2 */
Obdelnik::Obdelnik() {
    this->a = 1;
    this->b = 2;
}

// konstruktor s parametry nastaví hodnoty stran na platné hodnoty
Obdelnik::Obdelnik(unsigned int a, unsigned int b) {
    if (!NastavStranu_a(a)) {
        this->a = 1;
    }
    if (!NastavStranu_b(b)) {
        this->b = 2;
    }
}

//kopírovací konstruktor
Obdelnik::Obdelnik(const Obdelnik &ob) {
    this->a = ob.a;
    this->b = ob.b;
}

// ZiskejStranu_a
unsigned int Obdelnik::ZiskejStranu_a() const {
    return this->a;
}

// ZiskejStranu_b
unsigned int Obdelnik::ZiskejStranu_b() const {
    return this->b;
}

//obvod
unsigned int Obdelnik::Obvod() const {
    return 2 * this->a + 2 * this->b;
}

// obsah
unsigned int Obdelnik::Obsah() const {
    return this->a * this->b;
}

//úhlopříčka
float Obdelnik::Uhlopricka() const {
    return std::sqrt(pow(a, 2) + pow(b, 2));
}

bool Obdelnik::KontrolaPlatnostiStrany(unsigned int strana) {
    return strana > 0;
}



bool Obdelnik::NastavStranu_a(unsigned int a) {
    if (KontrolaPlatnostiStrany(a)) {
        this->a = a;
        return true;
    } else
        return false;
}

bool Obdelnik::NastavStranu_b(unsigned int b) {
    if (KontrolaPlatnostiStrany(b)) {
        this->b = b;
        return true;
    } else
        return false;
}



std::ostream &operator<<(std::ostream &os, const Obdelnik &o) {
    os << "Strana a ma hodnotu " << o.ZiskejStranu_a() << "." << std::endl;
    os << "Strana b ma hodnotu " << o.ZiskejStranu_b() << "." << std::endl;
    os << "Obvod obdelnika je " << o.Obvod() << "." << std::endl;
    os << "Obsah obdelnika je " << o.Obsah() << "." << std::endl;
    os << "Uhlopricka obdelnika je " << o.Uhlopricka() << "." << std::endl;
    return os;
}


