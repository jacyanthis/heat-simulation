module io_module
  implicit none
  
  type point
    real*8::temp, new_temp
    integer::hold
  end type

  contains
    subroutine readInputParameters(fp, field_size_x, field_size_y, alpha, num_ts)
      integer::fp, field_size_x, field_size_y, num_ts
      real*8::alpha
      read(fp, *) field_size_x, field_size_y, alpha, num_ts
    end subroutine

   subroutine readHeatMap(fp, field_size_x, field_size_y, heat_map)
      integer::fp, field_size_x, field_size_y, i, j, hold, x_pos_int, y_pos_int, end_of_file
      real*8::temp
      character(30)::x_pos,y_pos
      type(point)::heat_map(0:,0:)
      end_of_file = 0
      do while (end_of_file == 0)
        read(fp, *, iostat = end_of_file) x_pos, y_pos, temp, hold
        if (end_of_file == 0) then
          if (trim(x_pos) == "*".and.trim(y_pos) == "*") then
            do i=0,field_size_x
              do j=0,field_size_y
                heat_map(i,j)%temp = temp
                heat_map(i,j)%new_temp = temp
                heat_map(i,j)%hold = hold
              end do
            end do
          else if (trim(x_pos) == "*") then
            do i=0,field_size_x
              read(y_pos, *) y_pos_int
              heat_map(i,y_pos_int)%temp = temp
              heat_map(i,y_pos_int)%new_temp = temp
              heat_map(i,y_pos_int)%hold = hold
            end do
          else if (trim(y_pos) == "*") then
            do i=0,field_size_y
              read(x_pos, *) x_pos_int
              heat_map(x_pos_int,i)%temp = temp
              heat_map(x_pos_int,i)%new_temp = temp
              heat_map(x_pos_int,i)%hold = hold
            end do
          else
            read(x_pos, *) x_pos_int
            read(y_pos, *) y_pos_int
            heat_map(x_pos_int,y_pos_int)%temp = temp
            heat_map(x_pos_int,y_pos_int)%new_temp = temp
            heat_map(x_pos_int,y_pos_int)%hold = hold
          end if
        end if
      end do
    end subroutine

    subroutine writeOutput(fp, i, j, temp)
      integer::fp, i, j
      real*8::temp
      write(fp, *) i, " ", j, " ", temp
    end subroutine

end module
    
