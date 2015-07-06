all : C Fortran

C : c/main.o c/update_funcs.o c/io_funcs.o
	icc -o c/main c/main.o c/update_funcs.o c/io_funcs.o

c/main.o : c/main.c c/update_funcs.h c/io_funcs.h
	icc -c c/main.c -o c/main.o

c/update_funcs.o : c/update_funcs.c c/update_funcs.h
	icc -c c/update_funcs.c -o c/update_funcs.o

c/io_funcs.o : c/io_funcs.c c/io_funcs.h
	icc -c c/io_funcs.c -o c/io_funcs.o

Fortran : fortran/main.o fortran/io_module.o fortran/update_module.o
	ifort -g -o fortran/main fortran/main.o fortran/io_module.o fortran/update_module.o

fortran/main.o : fortran/main.f90 fortran/io_module.o fortran/update_module.o
	ifort -g -c fortran/main.f90 -o fortran/main.o

fortran/io_module.o : fortran/io_module.f90
	ifort -g -c fortran/io_module.f90 -o fortran/io_module.o

fortran/update_module.o : fortran/update_module.f90 fortran/io_module.o
	ifort -g -c fortran/update_module.f90 -o fortran/update_module.o

clean :
	rm c/*.o fortran/*.o *.mod c/main fortan/main* *_*.dat

figures :
	./text.sh

