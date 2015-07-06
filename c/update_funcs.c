#include "update_funcs.h"
#include <stdio.h>

point updateHeat(int i, int j, int field_size_x, int field_size_y, double alpha, point **heat_map) {

  point heat = heat_map[i][j];

  if (i == 0 && j == 0) {
    heat.new_temp = heat.temp + alpha * (heat_map[1][0].temp + heat_map[1][1].temp + heat_map[0][1].temp - (3 * heat.temp));
  }

  else if (i == 0 && j == (field_size_y - 1)) {
    heat.new_temp = heat.temp + alpha * (heat_map[1][j].temp + heat_map[1][j - 1].temp + heat_map[0][j - 1].temp - (3 * heat.temp));
  }

  else if (i == (field_size_x - 1) && j == (field_size_y - 1)) {
    heat.new_temp = heat.temp + alpha * (heat_map[i - 1][j].temp + heat_map[i - 1][j - 1].temp + heat_map[i][j - 1].temp - (3 * heat.temp));
  }

  else if (i == (field_size_x - 1) && j == 0) {
    heat.new_temp = heat.temp + alpha * (heat_map[i - 1][0].temp + heat_map[i - 1][1].temp + heat_map[i][1].temp - (3 * heat.temp));
  }

  else if (i == 0) {
    heat.new_temp = heat.temp + alpha * (heat_map[0][j - 1].temp + heat_map[0][j + 1].temp + heat_map[1][j - 1].temp + heat_map[1][j].temp + heat_map[1][j + 1].temp - (5 * heat.temp));
  }

  else if (j == 0) {
    heat.new_temp = heat.temp + alpha * (heat_map[i - 1][0].temp + heat_map[i + 1][0].temp + heat_map[i - 1][1].temp + heat_map[i][1].temp + heat_map[i + 1][1].temp - (5 * heat.temp));
  }

  else if (i == (field_size_x - 1)) {
    heat.new_temp = heat.temp + alpha * (heat_map[i][j - 1].temp + heat_map[i][j + 1].temp + heat_map[i - 1][j - 1].temp + heat_map[i - 1][j].temp + heat_map[i - 1][j + 1].temp - (5 * heat.temp));
  }

  else if (j == (field_size_y - 1)) {
    heat.new_temp = heat.temp + alpha * (heat_map[i - 1][j].temp + heat_map[i + 1][j].temp + heat_map[i - 1][j - 1].temp + heat_map[i][j - 1].temp + heat_map[i + 1][j - 1].temp - (5 * heat.temp));
  }

  else {
    heat.new_temp = heat.temp + alpha * (heat_map[i - 1][j - 1].temp + heat_map[i - 1][j].temp + heat_map[i - 1][j + 1].temp + heat_map[i][j - 1].temp + heat_map[i][j + 1].temp + heat_map[i + 1][j - 1].temp + heat_map[i + 1][j].temp + heat_map[i + 1][j + 1].temp - (8 * heat.temp));
  }

  return heat;

}
