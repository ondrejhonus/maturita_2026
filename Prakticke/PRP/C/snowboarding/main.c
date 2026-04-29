#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define SIZE 100
#define MAX_RACERS 15
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

int read_file(RACER racers[]) {
  FILE* fr = fopen(INPUT_FILE, "r");
  int count = 0;

  char header[SIZE];
  fgets(header, sizeof(header), fr);

  while (count < MAX_RACERS &&
         fscanf(fr, "%[^|]|%[^|]|%d.%d|%d.%d|%d:%d.%d\n", &racers[count].name,
                &racers[count].state, &racers[count].blue_time.s,
                &racers[count].blue_time.hun, &racers[count].red_time.s,
                &racers[count].red_time.hun, &racers[count].total_time.m,
                &racers[count].total_time.s,
                &racers[count].total_time.hun) == 9) {
    count++;
  }

  if (fclose(fr) == EOF) perror("File could not be closed");
  return count;
}

void swap(RACER* a, RACER* b) {
  RACER temp = *a;
  *a = *b;
  *b = temp;
}

int time_to_hun(TIME t) { return t.m * 60 * 100 + t.s * 100 + t.hun; }

void bubble_sort(RACER racer[], int count) {
  for (size_t i = 0; i < count - 1; i++) {
    for (size_t j = 0; j < count - i - 1; j++) {
      if (time_to_hun(racer[j].total_time) >
          time_to_hun(racer[j + 1].total_time)) {
        swap(&racer[j], &racer[j + 1]);
      }
    }
  }
}

void display_racers(RACER racers[], int count) {
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

int main() {
  RACER racers[MAX_RACERS];
  int count = read_file(racers);
  bubble_sort(racers, count);
  display_racers(racers, count);
}
