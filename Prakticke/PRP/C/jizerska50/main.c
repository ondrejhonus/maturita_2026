#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define INPUT_FILE "jizerska50.txt"
#define DELIM ";(),\n"
#define SIZE 100

typedef struct {
  int h, m, s;
} TIME;

typedef struct {
  int start_n;
  char surname[SIZE];
  char name[SIZE];
  int year;
  char nat[SIZE];
  TIME time;
} RACER;

RACER* read_file(int* count) {
  FILE* fr = fopen(INPUT_FILE, "r");

  char line[SIZE];
  char* pch;
  *count = 0;

  RACER* racers = NULL;
  RACER* more_racers = NULL;

  int col = 0;

  if (fr == NULL) {
    perror("file could not be opened");
  } else {
    while (fgets(line, SIZE, fr) != NULL) {
      col = 0;
      if (*count != 0) {
        more_racers = (RACER*)realloc(racers, (*count + 1) * sizeof(RACER));
        if (more_racers != NULL) {
          racers = more_racers;
          pch = strtok(line, DELIM);
          while (pch != NULL) {
            switch (col) {
              case 0:
                racers[*count - 1].start_n = atoi(pch);
                break;
              case 1:
                strcpy(racers[*count - 1].surname, pch);
                break;
              case 2:
                strcpy(racers[*count - 1].name, pch);
                break;
              case 3:
                racers[*count - 1].year = atoi(pch);
              case 4:
                strcpy(racers[*count - 1].nat, pch);
                break;
              case 5:
                sscanf(pch, "%d:%d:%d", &racers[*count - 1].time.h,
                       &racers[*count - 1].time.m, &racers[*count - 1].time.s);
                break;
              default:
                break;
            }
            col++;
            pch = strtok(NULL, DELIM);
          }
        } else {
          perror("Realloc problem");
          break;
        }
      }
      (*count)++;
    }
    if (fclose(fr) == EOF) perror("File could not be closed");
  }
  (*count)--;
  return racers;
}

int time_to_sec(TIME t) { return t.h * 60 * 60 + t.m * 60 + t.s; }

void swap(RACER* a, RACER* b) {
  RACER temp = *a;
  *a = *b;
  *b = temp;
}

void bubble_sort(RACER* racers, int count) {
  for (size_t i = 0; i < count - 1; i++) {
    for (size_t j = 0; j < count - i - 1; j++) {
      if (time_to_sec(racers[j].time) > time_to_sec(racers[j + 1].time)) {
        swap(&racers[j], &racers[j + 1]);
      }
    }
  }
}

void display_racers(RACER* racers, int count) {
  printf(
      "========================================================================"
      "=====\n");
  printf("nevim nebavi me to tady tohle psat\n");
  printf(
      "========================================================================"
      "=====\n");
  printf(
      "poradi   cislo           jmeno       prijmeni    rok       zeme      "
      "   cas\n");
  printf(
      "========================================================================"
      "=====\n");

  for (size_t i = 0; i < count; i++) {
    printf("%6d %7d %15s %15s %5d %10s    %02d:%02d:%02d\n", i + 1,
           racers[i].start_n, racers[i].surname, racers[i].name, racers[i].year,
           racers[i].nat, racers[i].time.h, racers[i].time.m, racers[i].time.s);
  }
  printf(
      "========================================================================"
      "=====\n");
}

int main(int, char**) {
  int count = 0;
  RACER* racers = read_file(&count);
  bubble_sort(racers, count);
  display_racers(racers, count);
}
