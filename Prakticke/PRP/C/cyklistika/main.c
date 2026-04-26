#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define INPUT_FILE "cyklistika.txt"
#define DELIMITERS ";\n"
#define SIZE 100

typedef struct {
  int h, m, sec, hun;
} TIME;

typedef struct {
  int number;
  char surname[50];
  char name[50];
  int year;
  char club[50];
  TIME time;
} RACER;

RACER* read_file(int* count) {
  FILE* fr = fopen(INPUT_FILE, "r");
  RACER* racers = NULL;
  RACER* more_racers = NULL;

  *count = 0;
  int col = 0;

  char* pch = NULL;
  char line[SIZE];

  if (fr == NULL) {
    perror("File could not be openeed.\n");
  } else {
    while (fgets(line, SIZE, fr) != NULL) {
      col = 0;
      if (count != 0) {
        more_racers = (RACER*)realloc(racers, (*count) * sizeof(RACER));
        if (more_racers != NULL) {
          racers = more_racers;
          pch = strtok(line, DELIMITERS);
          while (pch != NULL) {
            switch (col) {
              case 0:
                racers[*count - 1].number = atoi(pch);
                break;
              case 1:
                strcpy(racers[*count - 1].surname, pch);
                break;
              case 2:
                strcpy(racers[*count - 1].name, pch);
                break;
              case 3:
                racers[*count - 1].year = atoi(pch);
                break;
              case 4:
                strcpy(racers[*count - 1].club, pch);
                break;
              case 5:
                sscanf(pch, "%d:%d:%d.%d", &racers[*count - 1].time.h,
                       &racers[*count - 1].time.m, &racers[*count - 1].time.sec,
                       &racers[*count - 1].time.hun);
                break;
            }
            pch = strtok(NULL, DELIMITERS);
            col++;
          }
        } else {
          free(racers);
          puts("Error parsin.");
          break;
        }
      }
      (*count)++;
    }
  }
  (*count)--;
  return racers;
}

int time_to_hun(TIME t) {
  return t.h * 360000 + t.m * 6000 + t.sec * 100 + t.hun;
}

void swap(RACER* a, RACER* b) {
  RACER temp = *a;
  *a = *b;
  *b = temp;
}

void bubble_sort(RACER* racers, int count) {
  for (size_t i = 0; i < count - 1; i++) {
    for (size_t j = 0; j < count - i - 1; j++) {
      if (time_to_hun(racers[j].time) > time_to_hun(racers[j + 1].time)) {
        swap(&racers[j], &racers[j + 1]);
      }
    }
  }
}

void display_racers(RACER* racer, int count) {
  printf("VYSLEDKOVA LISTINA\n");
  printf(
      "------------------------------------------------------------------------"
      "-------------------\n");
  printf(
      "poradi  startovni_cislo   prijmeni   jmeno   rocnik           klub      "
      "   cas\n");
  printf(
      "------------------------------------------------------------------------"
      "-------------------\n");

  for (size_t i = 0; i < count; i++) {
    printf("%5d   %5d %10s %10s %5d %35s %10d:%02d:%02d.%02d\n", i + 1,
           racer[i].number, racer[i].surname, racer[i].name, racer[i].year,
           racer[i].club, racer[i].time.h, racer[i].time.m, racer[i].time.sec,
           racer[i].time.hun);
  }
}

int main(int, char**) {
  int count = 0;
  RACER* racers = read_file(&count);
  bubble_sort(racers, count);
  display_racers(racers, count);
}
