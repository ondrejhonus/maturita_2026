#include <iostream>
#include "zlomek.h"

#include "zlomek.h"
#include <cstring>
#include <iostream>
using std::cout;
using std::cin;
using std::endl;

void vypis(zlomek & z, const char *text){
    cout << text << endl;
    for (int i = 0; i < strlen(text); i++) {
            cout << "-";
    }
    cout << endl;
    cout << z << "   " << z.desetinne() ;
    z.prevraceni();
    cout << "   " << z;
    if (z.kraceni()){
        cout << "   " << z << endl;
    }
    else {
        cout << "   " << "Zlomek je v zakladnim tvaru."<<endl;
    }
    cout <<endl;
    return;
}

void nastavHodnotyZlomku(zlomek & z) {
    int citatel, jmenovatel;
    cout << "Zadej citatele:";
    cin >> citatel;
    cout << "Zadej jmenovatele: ";
    cin >> jmenovatel;
    cout << endl;
    if (z.setZlomek(citatel, jmenovatel)) {
        vypis(z,"Objekt po zmene");
    } else {
        cout << "Jmenovatel nemuze byt nula." << endl;
    }
    return;
}

bool ukonci(){
    char klavesa;
    cout << "Klavesou \'k\' bude zadavani ukonceno: ";
    cin >> klavesa;
    cout << endl;
    if (klavesa == 'k'){
        return true;
    }
    else {
        return false;
    }
}

int main(int argc, char** argv) {
    zlomek z1;
    zlomek z2(1, 2);
    zlomek z3(z2);
    vypis(z1,"Objekt z1 vytvoreny vychozim konstruktorem");
    vypis(z2,"Objekt z2 vytvoreny konstruktorem s parametry");
    vypis(z3,"Objekt z3 vytvoreny kopirovacim konstruktorem z objektu z2");
    do {
        nastavHodnotyZlomku(z1);
        cout << endl << endl;
    } while (!ukonci());
 return 0;
}
