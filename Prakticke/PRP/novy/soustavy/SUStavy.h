*#ifndef SOUSTAVY_SUSTAVY_H
#define SOUSTAVY_SUSTAVY_H

#include <string>
#include <ostream>


class SUStavy {
public:
    SUStavy();
    SUStavy(std::string cislo, int base);
    SUStavy(const SUStavy &);
    ~SUStavy();

    bool setNum(std::string num, int base);

    std::string getNum(int base) const;

private:
    unsigned int toDec(std::string num, int base) const;
    std::string toBase(unsigned int cislo,int base) const;

    unsigned int decNum;

    bool checkBaseInt(int base) const;
    bool checkNumInBase(std::string num, int base) const;
};

std::ostream & operator<<(std::ostream &, const SUStavy &);

#endif //SOUSTAVY_SUSTAVY_H
