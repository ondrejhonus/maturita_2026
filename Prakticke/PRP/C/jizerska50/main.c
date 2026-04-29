#include <stdio.h>
#include <stdlib.h>

#define SIZE 100
#define MAX_RACERS 30
#define INPUT_FILE "jizerska50.txt"

typedef struct {
  int h, m, s;
} TIME;

typedef struct {
  int num;
  char surname[SIZE];
  char name[SIZE];
  int year;
  char state[5];
  TIME time;
} RACER;

int read_file(RACER racers[]) {
  FILE* fr = fopen(INPUT_FILE, "r");
  int count = 0;

  char header[SIZE];
  fgets(header, sizeof(header), fr);

  while (count < MAX_RACERS &&
         fscanf(fr, "%d;%[^,], %[^(](%d);%[^;];%d:%d:%d", &racers[count].num,
                &racers[count].surname, &racers[count].name,
                &racers[count].year, &racers[count].state,
                &racers[count].time.h, &racers[count].time.m,
                &racers[count].time.s) == 8) {
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

void display_racers(RACER racers[], int count) {
  printf("Whatever, hlavicka nejaka.\n");
  printf(
      "poradi   cislo    jmeno            prijmeni    rok  zeme        cas\n");
  for (unsigned int i = 0; i < count; i++) {
    printf("%5d. %5d %15s %15s %5d %5s %4d:%02d:%02d\n", i + 1, racers[i].num,
           racers[i].surname, racers[i].name, racers[i].year, racers[i].state,
           racers[i].time.h, racers[i].time.m, racers[i].time.s);
  }
}

int main() {
  RACER racers[MAX_RACERS];
  int count = read_file(racers);
  display_racers(racers, count);
}
