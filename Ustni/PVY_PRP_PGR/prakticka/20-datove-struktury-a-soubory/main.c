#include <stdio.h>
#include <string.h>
#define INPUT "evropa.txt"
#define OUTPUT "evropa_kopie.txt"
#define SIZE 200

void replaceChar(char mystr[SIZE], char from, char to) {
    for (int i = 0; i < strlen(mystr); i++) {
        if (mystr[i] == from) {
            mystr[i] = to;
        }
    }
}

void printFile() {
    FILE * fr;
    fr = fopen(INPUT, "r");
    FILE * fw;
    fw = fopen(OUTPUT, "w");
    char mystring [SIZE];

    if (fr == NULL) {
        printf("The file %s did not open", INPUT);
    }
    else {
        if (fw == NULL) {
           printf("The file %s did not open", OUTPUT);
            fclose (fr);
        } else {
            while(fgets (mystring , SIZE , fr) != NULL ) {
                replaceChar(mystring, 's', '$');
                fprintf(fw,mystring);
            }
            if (fclose(fw) == EOF) {
                printf("The file %s did not close", OUTPUT);
            }
            if (fclose (fr) == EOF) {
                printf("The file %s did not close", INPUT);
            }
        }
    }
}


int main(void) {
    printFile();
    return 0;
}