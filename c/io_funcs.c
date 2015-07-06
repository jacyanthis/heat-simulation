#include "io_funcs.h"
#include <stdio.h>

void readInputParameters(FILE* input, int *field_size_x, int *field_size_y, double *alpha, int *num_ts) {

  fscanf(input, "%d %d %lf %d", field_size_x, field_size_y, alpha, num_ts);

}

void readHeatMap(FILE* input, int field_size_x, int field_size_y, point*** heat_map) {

  char x_pos[50], y_pos[50];
  double temp;
  int i, j, hold, x_pos_int, y_pos_int;

  int moreData = 1;
  while (moreData) {
    int itemsRead = fscanf(input, "%s %s %lf %d", x_pos, y_pos, &temp, &hold);
    if (itemsRead == 4) {
      if ((strncmp(x_pos, "*", 1) == 0) && (strncmp(y_pos, "*", 1) == 0)) {
        for (i = 0; i < field_size_x; i++) {
          for (j = 0; j < field_size_y; j++) {
            (*heat_map)[i][j].temp = temp;
            (*heat_map)[i][j].new_temp = temp;
            (*heat_map)[i][j].hold = hold;
          }
        }
      }  
      else {
        if (strncmp(x_pos, "*", 1) == 0) {
          y_pos_int = atoi(y_pos);
          for(i = 0; i < field_size_x; i++) {
            (*heat_map)[i][y_pos_int].temp = temp;
            (*heat_map)[i][y_pos_int].new_temp = temp;
            (*heat_map)[i][y_pos_int].hold = hold;
          }
        }
        else {
          if (strncmp(y_pos, "*", 1) == 0) {
            x_pos_int = atoi(x_pos);
            for(i = 0; i < field_size_y; i++) {
              (*heat_map)[x_pos_int][i].temp = temp;
              (*heat_map)[x_pos_int][i].new_temp = temp;
              (*heat_map)[x_pos_int][i].hold = hold;
            }
          }
          else {
            x_pos_int = atoi(x_pos);
            y_pos_int = atoi(y_pos);
            (*heat_map)[x_pos_int][y_pos_int].temp = temp;
            (*heat_map)[x_pos_int][y_pos_int].new_temp = temp;
            (*heat_map)[x_pos_int][y_pos_int].hold = hold;
          }
        }
      }
    } 
    else {
      moreData = 0;
    }
  }
}

void writeOutput(FILE* output, int i, int j, double temp) {
  fprintf(output, "%d %d %lf\n", i, j, temp);
} 
