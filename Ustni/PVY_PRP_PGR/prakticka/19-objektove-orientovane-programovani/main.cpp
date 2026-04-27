#include <iostream>
#include "Obdelnik.h"

using std::cout;
using std::endl;

int main() {
    // vytvoření objektu MujObdelnik výchozím konstruktorem
    Obdelnik MujObdelnik;

    // výpis hodnot objektu MujObdelnik
    cout << "Objekt vytvoreny vychozim konstruktorem " << MujObdelnik << endl;

    Obdelnik TvujObdelnik(10, 15);
    // výpis hodnot objektu TvujObdelnik
    cout << "Objekt vytvoreny konstruktorem s parametry " << TvujObdelnik << endl;

    /* objekt je nevhodně inicializován na alespoň jednu nulovou hodnotu.
     * Konstruktor zajistí jejich inicializaci
    na přípustnou hodnotu*/
    Obdelnik DalsiObdelnik(0, 15);
    cout << "DalsiObdelnik " << DalsiObdelnik << endl;


    // vytvoření objektu kopírovacím konstruktorem
    Obdelnik KopieObdelniku(DalsiObdelnik);

    // výpis hodnot objektu vytvořeného kopírovacím konstruktorem
    cout << "Kopie DalsiObdelnik " << KopieObdelniku << endl;

    return 0;
}
