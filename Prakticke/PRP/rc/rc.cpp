//
// Created by ENDRU on 31.03.2025.
//

#include "rc.h"
#include <ctime>

rc::rc() {
mRC=defaultRC;
}

rc::rc(std::string rc) {
    if(isValid(rc)){
        this->mRC=rc;
    }else{
        this->mRC=defaultRC;
    }
}

rc::rc(const rc &rc) {
this->mRC=rc.mRC;
}

rc::~rc() {

}

void rc::setrc(std::string rc) {
    if (isValid(rc)){
        this->mRC;
    }else{
        this->mRC=defaultRC;
    }
}

std::string rc::getrc() const {
    return this->mRC;
}

bool rc::isValid(std::string rc) {
    if(rc.length() != 10){
        return false;
    }
    for (int i = 0; i < rc.length(); ++i) {
        if (rc[i] < '0'|| rc[i] > '9'){
            return false;
        }
    }
    int kontrolniCislo = std::stoi(rc.substr(9,1));
    int zbytek = std::stoi(rc.substr(0,9) )% 11;

    if (kontrolniCislo == zbytek || (zbytek == 10 && kontrolniCislo == 10)){
        return true;
    }else{
        return false;
    }
}

bool rc::getGender() const {
    int month = std::stoi(mRC.substr(2,2));
            if (month < 50){
                return false;
            }else{
                return true;
            }
}

int rc::month() const {
    int month = std::stoi(mRC.substr(2,2));
    if (getGender()) {
        month -= 50;
    }
    return month;
}

int rc::day() const {
    int day = std::stoi(mRC.substr(4,2));
    return day;
}

int rc::year() const {
    int year = std::stoi(mRC.substr(0,2));
    if(year <= 54){
        year+=2000;
    }else{
        year+=1900;
    }
    return year;
}

int rc::getAge() const {
    time_t timestamp;
    time(&timestamp);

    struct tm * date = localtime(&timestamp);
    int sysYear = date->tm_year + 1900;
    int sysMonth = date->tm_mon + 1;
    int sysDay = date->tm_mday;
    int age = sysYear - year();
    if (sysMonth < month()) {
        age--;
    }
    else if (sysMonth == month() && sysDay < day()) {
        age--;
    }

    return age;
}
