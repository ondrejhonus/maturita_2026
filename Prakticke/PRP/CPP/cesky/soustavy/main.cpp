#include <iostream>
#include "SUStavy.h"
#include <iostream>
#include "SUStavy.h"

using std::endl;
using std::cout;
using std::string;

// změna typu z `prevody` na `SUStavy`
void vypisObjektu(const SUStavy & p, string text) {
    cout << text << endl;
    for (int i = 0; i < text.length(); i++) {
        cout << "-";
    }
    cout << endl;
    cout << p << endl;
    return;
}

int main(int argc, char** argv) {
    SUStavy p1;
    SUStavy p2("1101", 2);
    SUStavy p3("ABCD", 16);
    SUStavy p4(p3);

    vypisObjektu(p1, "Objekt vytvoreny vychozim konstruktorem");
    vypisObjektu(p2, "Objekt vytvoreny konstruktorem s parametrem");
    vypisObjektu(p3, "Objekt vytvoreny konstruktorem s parametrem");
    vypisObjektu(p4, "Objekt vytvoreny kopirovacim konstruktorem");

    return 0;
}

