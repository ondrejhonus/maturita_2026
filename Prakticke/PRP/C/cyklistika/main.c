#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define INPUT_FILE "cyklistika.txt"
#define DELIMITERS ";\n"
#define SIZE 100
#define MAX_RACERS 20

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

int read_file(RACER racers[]) {
  FILE* fr = fopen(INPUT_FILE, "r");

  int count = 0;

  char header[SIZE];
  fgets(header, sizeof(header), fr);

  while (count < MAX_RACERS &&
         fscanf(fr, "%d;%[^;];%[^;];%d;%[^;];%d:%d:%d.%d\n",
                &racers[count].number, &racers[count].surname,
                &racers[count].name, &racers[count].year, &racers[count].club,
                &racers[count].time.h, &racers[count].time.m,
                &racers[count].time.sec, &racers[count].time.hun) == 9) {
    count++;
  }
  fclose(fr);
  return count;
}

int time_to_hun(TIME t) {
  return t.h * 360000 + t.m * 6000 + t.sec * 100 + t.hun;
}

void swap(RACER* a, RACER* b) {
  RACER temp = *a;
  *a = *b;
  *b = temp;
}

void bubble_sort(RACER racers[], int count) {
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
  RACER racers[MAX_RACERS];
  int count = read_file(racers);
  bubble_sort(racers, count);
  display_racers(racers, count);
}
