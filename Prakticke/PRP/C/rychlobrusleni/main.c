#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define INPUT_FILE "rychlobrusleni10000m.txt"
#define SIZE 100
#define MAX_RACERS 30

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

void bubble_sort(DATA racers[], int count) {
  for (unsigned int i = 0; i < count - 1; i++) {
    for (unsigned int j = 0; j < count - i - 1; j++) {
      if (time_to_hun(racers[j].time) > time_to_hun(racers[j + 1].time)) {
        swap(&racers[j], &racers[j + 1]);
      }
    }
  }
}

int read_file(DATA racers[]) {
  FILE* fr = fopen(INPUT_FILE, "r");
  int count = 0;

  char header[SIZE];
  fgets(header, sizeof(header), fr);

  // 1 Riccardo Lorello (ITA) 12:56.22
  while (count < MAX_RACERS &&
         fscanf(fr, "%d %[^ ] %[^ ] (%[^)]) %d:%d.%d\n",
                &racers[count].start_num, &racers[count].name,
                &racers[count].surname, &racers[count].country,
                &racers[count].time.m, &racers[count].time.sec,
                &racers[count].time.hun) == 7) {
    count++;
  }
  fclose(fr);
  return count;
}

void print_racers(DATA racers[], int count) {
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
  DATA racers[MAX_RACERS];
  int count = read_file(racers);
  bubble_sort(racers, count);
  print_racers(racers, count);
}
