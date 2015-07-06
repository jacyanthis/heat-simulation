program semester_project
  use io_module
  use update_module
  implicit none

  !Define types
  integer::i ,j, k, num_ts, output_freq, field_size_x, field_size_y, num_arguments
  real*8::alpha
  type(point),allocatable::heat_map(:,:)
  character(30)::out_file_basename, input_file, filename, string_output_freq

  !Read command line
  num_arguments = NARGS()
  if (num_arguments == 4) then
    call GETARG(1, input_file)
    call GETARG(2, string_output_freq)
      read(string_output_freq, *) output_freq
    call GETARG(3, out_file_basename)
  else
    print *, "This program requires three arguments in order: input file name, output frequency, output file basename"
  end if

  !Open files
  open(unit=1, file=input_file)

  !Read field size, alpha, and number of timesteps
  call readInputParameters(1, field_size_x, field_size_y, alpha, num_ts)

  !Allocate heat map
  allocate(heat_map(0:field_size_x,0:field_size_y))

  !Read heat map
  call readHeatMap(1, field_size_x, field_size_y, heat_map)

  !Update heats and write results
  do i=0,num_ts
    if (mod(i,output_freq) == 0) then
      write(filename, fmt = "(2A, I0.4, A)") trim(out_file_basename), "_", i, ".dat"
      open(unit = 2, file=filename)
    end if
    do j=0, field_size_x
      do k=0, field_size_y
        if (i > 0) then
          if (heat_map(j,k)%hold == 0) then
            heat_map(j,k) = updateHeat(j, k, field_size_x, field_size_y, alpha, heat_map)
          end if
        end if
        if (mod(i,output_freq) == 0) then
          call writeOutput(2, j, k, heat_map(j,k)%new_temp)
        end if  
      end do
    end do
    if (mod(i,output_freq) == 0) then
      close(2)
    end if
    do j=0,field_size_x
      do k=0,field_size_y
        if (heat_map(j,k)%hold == 0) then
          heat_map(j,k)%temp = heat_map(j,k)%new_temp
        end if
      end do
    end do
  end do

  !Close input file
  close(1)

  !Deallocate array
  deallocate(heat_map)

end program semester_project
