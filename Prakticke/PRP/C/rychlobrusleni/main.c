#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define INPUT_FILE "rychlobrusleni10000m.txt"
#define SIZE 100
#define DELIMITERS "() \n"

typedef struct {
  int m, sec, hun;
} TIME;

typedef struct {
  int start_num;
  char name[SIZE];
  char surname[SIZE];
  char country[10];
  TIME time;
} DATA;

void swap(DATA* a, DATA* b) {
  DATA temp = *a;
  *a = *b;
  *b = temp;
}

int time_to_hun(TIME t) { return t.m * 6000 + t.sec * 100 + t.hun; }

void bubble_sort(DATA* racers, int count) {
  for (unsigned int i = 0; i < count - 1; i++) {
    for (unsigned int j = 0; j < count - i - 1; j++) {
      if (time_to_hun(racers[j].time) > time_to_hun(racers[j + 1].time)) {
        swap(&racers[j], &racers[j + 1]);
      }
    }
  }
}

DATA* read_file(int* count) {
  FILE* fr = fopen(INPUT_FILE, "r");
  char line[SIZE];
  char* pch = NULL;
  DATA* racer = NULL;
  DATA* more_racers = NULL;
  int col = 0;
  *count = 0;

  if (fr == NULL) {
    perror("File could not be opened!");
  } else {
    while (fgets(line, SIZE, fr)) {
      col = 0;
      if (*count != 0) {
        more_racers = (DATA*)realloc(racer, (*count + 1) * sizeof(DATA));
        if (more_racers != NULL) {
          racer = more_racers;
          pch = strtok(line, DELIMITERS);
          while (pch != NULL) {
            switch (col) {
              case 0:
                racer[*count - 1].start_num = atoi(pch);
                break;
              case 1:
                strcpy(racer[*count - 1].name, pch);
                break;
              case 2:
                strcpy(racer[*count - 1].surname, pch);
                break;
              case 3:
                strcpy(racer[*count - 1].country, pch);
                break;
              case 4:
                sscanf(pch, "%d:%d.%d", &racer[*count - 1].time.m,
                       &racer[*count - 1].time.sec,
                       &racer[*count - 1].time.hun);
                break;
              default:
                break;
            }
            pch = strtok(NULL, DELIMITERS);
            col++;
          }

        } else {
          free(racer);
          puts("Error (re)allocating memory");
          break;
        }
      }
      (*count)++;
    }
    printf("%s", fclose(fr) == EOF ? "File couldn't be opened\n"
                                   : "File succesfully closed\n");
  }
  (*count)--;
  return racer;
}

void print_racers(DATA* racers, int count) {
  printf("R Y C H L O B R U S L E N I   2 0 2 6\n10 000m muzi\n");
  printf("---------------------------------------------------\n");
  printf("poradi        jmeno     prijmeni   stat       cas\n");
  for (unsigned int i = 0; i < count; i++) {
    printf("%5d. %12s %12s %6s %3d:%02d.%02d\n", i + 1, racers[i].name,
           racers[i].surname, racers[i].country, racers[i].time.m,
           racers[i].time.sec, racers[i].time.hun);
  }
}

int main(int, char**) {
  int count = 0;
  DATA* racers = read_file(&count);
  bubble_sort(racers, count);
  print_racers(racers, count);
}
