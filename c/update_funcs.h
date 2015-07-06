#ifndef __POINT__
#define __POINT__

typedef struct {
  double temp;
  double new_temp;
  int hold;
} point;

#endif

#ifndef __UPDATE_FUNCS__
#define __UPDATE_FUNCS__
#include <stdio.h>

point updateHeat(int i, int j, int field_size_x, int field_size_y, double alpha, point **heat_map);

#endif
