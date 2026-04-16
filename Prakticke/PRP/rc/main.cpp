#include <iostream>
#include "rc.h"

int main() {
    rc r1;
    rc r2("0512123414");
    rc r3(r2);


    std::cout << r1 << std::endl;
    std::cout << r2 << std::endl;
    std::cout << r3 << std::endl;
    return 0;
}
