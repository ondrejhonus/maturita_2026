#ifndef OBDELNIKMATURITA24B_OBDELNIK_H
#define OBDELNIKMATURITA24B_OBDELNIK_H

#include <ostream>

class Obdelnik {
public:
    Obdelnik();

    Obdelnik(unsigned int, unsigned int);

    Obdelnik(const Obdelnik &);

    ~Obdelnik() = default;

    unsigned int ZiskejStranu_a() const;
    unsigned int ZiskejStranu_b() const;
    bool NastavStranu_a(unsigned int);

    bool NastavStranu_b(unsigned int);

    unsigned int Obsah() const;

    unsigned int Obvod() const;

    float Uhlopricka() const;

    friend std::ostream &operator<<(std::ostream &, const Obdelnik &);

private:
    unsigned int a, b;

    bool KontrolaPlatnostiStrany(unsigned int);
};


#endif //OBDELNIKMATURITA24B_OBDELNIK_H
