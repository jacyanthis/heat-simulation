#ifndef __POINT__
#define __POINT__

typedef struct {
  double temp;
  double new_temp;
  int hold;
} point;

#endif

#ifndef __IO_FUNCS__
#define __IO_FUNCS__
#include <stdio.h>

void readInputParameters(FILE* input, int *field_size_x, int *field_size_y, double *alpha, int *num_ts);

void readHeatMap(FILE* input, int field_size_x, int field_size_y, point*** heat_map);

void writeOutput(FILE* output, int i, int j, double temp);

#endif
