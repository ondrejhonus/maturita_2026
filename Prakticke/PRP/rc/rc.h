//
// Created by ENDRU on 31.03.2025.
//

#ifndef RC_RC_H
#define RC_RC_H


#include <string>

class rc {
public:
    rc();
    rc(std::string);
    rc(rc const&);
    ~rc();

    void setrc(std::string);
    std::string getrc()const;

    int year()const;
    int month()const;
    int day()const;

    int getAge()const;
    bool getGender()const;

private:
    bool isValid(std::string);
    const std::string defaultRC = "0512123414";
    std::string mRC;
};


#endif //RC_RC_H
