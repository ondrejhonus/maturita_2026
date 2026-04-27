#include <stdio.h>
#include <string.h>


//binarni na desitkovou
int binaryToDecimal(const char* bin) {
    int decimal = 0;
    int base = 1;
    int len = strlen(bin);

    for (int i = len - 1; i >= 0; i--) {
        if (bin[i] == '1') {
            decimal += base;
        }
        base *= 2;
    }
    return decimal;
}


//desitkova na binarniii
const char* decimalToBinary(int dec) {
    static char binary[33]; 
    
    if (dec == 0) {
        return "0";
    }

    binary[32] = '\0'; 
    int index = 31;    

    while (dec > 0) {
        binary[index] = (dec % 2) + '0'; 
        dec /= 2;
        index--;
    }

    return &binary[index + 1]; 
}

int main() {
    char binInput[33]; 
    int decInput = 0;
    printf("=== PROGRAM PRO PREVOD SOUSTAV ===\n\n");

    printf("Zadej binarni cislo (pouze nuly a jednicky): ");
    scanf("%32s", binInput); 
    
    int c;
    while ((c = getchar()) != '\n' && c != EOF);

    int resultDec = binaryToDecimal(binInput);
    printf("-> Binarni cislo %s je v desitkove soustave: %d\n\n", binInput, resultDec);

    printf("Zadej cele desitkove cislo: ");
    scanf("%d", &decInput); 
    
    const char* resultBin = decimalToBinary(decInput);
    printf("-> Desitkove cislo %d je v binarni soustave: %s\n\n", decInput, resultBin);

    return 0;
}