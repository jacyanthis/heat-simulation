#include <stdio.h>
#include <math.h>
#include "io_funcs.h"
#include "update_funcs.h"

int main(int argc, char **argv) {

  //Define types
  int i, j, k, num_ts, output_freq, field_size_x, field_size_y;
  double alpha;
  char filename[30], *out_file_basename, *input_file;
  FILE *input, *output;
  point **heat_map;

  //Read command line
  if(argc == 4) {
    input_file = argv[1];
    output_freq = atoi(argv[2]);
    out_file_basename = argv[3];
  } else {
    printf("This program requires three arguments in this order: input file name, output frequency, and output file basename.");
  }

  //Open input file
  input = fopen(input_file, "r+");

  //Read field size, alpha, and number of time-steps
  readInputParameters(input, &field_size_x, &field_size_y, &alpha, &num_ts);

  //Allocate heat map
  heat_map = (point**)malloc(sizeof(point*)*field_size_x);
  for(i = 0; i < field_size_x; i++) {
    heat_map[i] = (point*)malloc(sizeof(point)*field_size_y);
  }

  //Read heat map
  readHeatMap(input, field_size_x, field_size_y, &heat_map);

  //Update heats and write results
  for (i = 0; i <= num_ts; i++) {
    if (i % output_freq  == 0) {
      sprintf(filename, "%s_%.4d.dat", out_file_basename, i);
      output = fopen(filename, "w");
    }
    for (j = 0; j < field_size_x; j++) {
      for (k = 0; k < field_size_y; k++) {
        if (i > 0) {
          if (heat_map[j][k].hold == 0) {
            heat_map[j][k] = updateHeat(j, k, field_size_x, field_size_y, alpha, heat_map);
          }
        }
        if (i % output_freq == 0)  { 
          writeOutput(output, j, k, heat_map[j][k].new_temp);
        }
      }
    }
    if (i % output_freq == 0) {
      fclose(output);
    }
    
    //Reset buffer
    for (j = 0; j < field_size_x; j++) {
      for (k = 0; k < field_size_y; k++) {
        if (heat_map[j][k].hold == 0) {
          heat_map[j][k].temp = heat_map[j][k].new_temp;
        }
      }
    }
  }

  //Close input
  fclose(input);

  //Clean heap
  for(i = 0; i < field_size_x; i++) {
    free(heat_map[i]);
  }
  free(heat_map);
  return 0;
}
