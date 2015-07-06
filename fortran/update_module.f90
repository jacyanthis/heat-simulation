module update_module
  use io_module
  implicit none 

  contains

    function updateHeat(i, j, field_size_x, field_size_y, alpha, heat_map) result(heat)

      type(point)::heat, heat_map(0:,0:)
      integer::i, j, field_size_x, field_size_y
      real*8::alpha

      heat = heat_map(i,j)
    
      if (i == 0.and.j == 0) then
        heat%new_temp = heat%temp + alpha * (heat_map(1,0)%temp + heat_map(1,1)%temp + heat_map(0,1)%temp - (3 * heat%temp))

      else if (i == 0.and.j == (field_size_y - 1)) then
        heat%new_temp = heat%temp + alpha * (heat_map(1,j)%temp + heat_map(1,j - 1)%temp + heat_map(0,j - 1)%temp - (3 * heat%temp))

      else if (i == (field_size_x - 1).and.j == (field_size_y - 1)) then
        heat%new_temp = heat%temp + alpha * (heat_map(i - 1, j)%temp + heat_map(i - 1,j - 1)%temp + heat_map(i,j - 1)%temp - (3 * heat%temp))

      else if (i == (field_size_x - 1).and.j == 0) then
        heat%new_temp = heat%temp + alpha * (heat_map(i - 1,0)%temp + heat_map(i - 1, 1)%temp + heat_map(i,1)%temp - (3 * heat%temp))

      else if (i == 0) then
        heat%new_temp = heat%temp + alpha * (heat_map(0,j - 1)%temp + heat_map(0,j + 1)%temp + heat_map(1,j - 1)%temp + heat_map(1,j)%temp + heat_map(1,j + 1)%temp - (5 * heat%temp))

      else if (j == 0) then
        heat%new_temp = heat%temp + alpha * (heat_map(i - 1,0)%temp + heat_map(i + 1,0)%temp + heat_map(i - 1,1)%temp + heat_map(i,1)%temp + heat_map(i + 1,1)%temp - (5 * heat%temp))

      else if (i == (field_size_x - 1)) then
        heat%new_temp = heat%temp + alpha * (heat_map(i,j - 1)%temp + heat_map(i,j + 1)%temp + heat_map(i - 1,j - 1)%temp + heat_map(i - 1,j)%temp + heat_map(i - 1,j + 1)%temp - (5 * heat%temp))

      else if (j == (field_size_y - 1)) then
        heat%new_temp = heat%temp + alpha * (heat_map(i - 1,j)%temp + heat_map(i + 1,j)%temp + heat_map(i - 1,j - 1)%temp + heat_map(i,j - 1)%temp + heat_map(i + 1,j - 1)%temp - (5 * heat%temp))

      else
        heat%new_temp = heat%temp + alpha * (heat_map(i - 1,j - 1)%temp + heat_map(i - 1,j)%temp + heat_map(i - 1,j + 1)%temp + heat_map(i,j - 1)%temp + heat_map(i,j + 1)%temp + heat_map(i + 1,j - 1)%temp + heat_map(i + 1,j)%temp + heat_map(i + 1,j + 1)%temp - (8 * heat%temp))

      end if

    end function

end module
    
