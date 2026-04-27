#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define DELIM "|\n"
#define SIZE 100
#define INPUT_FILE "snowboarding.txt"

typedef struct {
  int m, s, hun;
} TIME;

typedef struct {
  char name[SIZE];
  char state[5];
  TIME blue_time;
  TIME red_time;
  TIME total_time;
} RACER;

RACER* read_file(int* count) {
  FILE* fr = fopen(INPUT_FILE, "r");
  *count = 0;
  char line[SIZE];
  char* pch;

  RACER* racers = NULL;
  RACER* temp_racers = NULL;

  int col = 0;

  if (fr == NULL) {
    perror("File not found.");
  } else {
    while (fgets(line, SIZE, fr) != NULL) {
      col = 0;
      if (*count != 0) {
        temp_racers = (RACER*)realloc(racers, (*count + 1) * sizeof(RACER));
        if (temp_racers != NULL) {
          racers = temp_racers;
          pch = strtok(line, DELIM);
          while (pch != NULL) {
            switch (col) {
              case 0:
                strcpy(racers[*count - 1].name, pch);
                break;
              case 1:
                strcpy(racers[*count - 1].state, pch);
                break;
              case 2:
                sscanf(pch, "%d.%d", &racers[*count - 1].blue_time.s,
                       &racers[*count - 1].blue_time.hun);
                break;
              case 3:
                sscanf(pch, "%d.%d", &racers[*count - 1].red_time.s,
                       &racers[*count - 1].red_time.hun);
                break;
              case 4:
                sscanf(pch, "%d:%d.%d", &racers[*count - 1].total_time.m,
                       &racers[*count - 1].total_time.s,
                       &racers[*count - 1].total_time.hun);
                break;
              default:
                break;
            }
            col++;
            pch = strtok(NULL, DELIM);
          }
        } else {
          perror("Realloc error");
          free(racers);
          break;
        }
      }
      (*count)++;
    }
  }
  (*count)--;
  return racers;
}

void swap(RACER* a, RACER* b) {
  RACER temp = *a;
  *a = *b;
  *b = temp;
}

int time_to_hun(TIME t) { return t.m * 60 * 100 + t.s * 100 + t.hun; }

void bubble_sort(RACER* racer, int count) {
  for (size_t i = 0; i < count - 1; i++) {
    for (size_t j = 0; j < count - i - 1; j++) {
      if (time_to_hun(racer[j].total_time) >
          time_to_hun(racer[j + 1].total_time)) {
        swap(&racer[j], &racer[j + 1]);
      }
    }
  }
}

void display_racers(RACER* racers, int count) {
  printf(
      "------------------------------------------------------------------------"
      "-----\n");
  printf(" poradi                jmeno  stat    modry  cerveny      celkem\n");
  printf(
      "------------------------------------------------------------------------"
      "-----\n");

  for (size_t i = 0; i < count; i++) {
    printf("%6d. %20s %5s %5d.%02d %5d.%02d %5d:%02d.%02d\n", i + 1,
           racers[i].name, racers[i].state, racers[i].blue_time.s,
           racers[i].blue_time.hun, racers[i].red_time.s,
           racers[i].red_time.hun, racers[i].total_time.m,
           racers[i].total_time.s, racers[i].total_time.hun);
  }
}

int main(int, char**) {
  int count = 0;
  RACER* racers = read_file(&count);
  bubble_sort(racers, count);
  display_racers(racers, count);
}
