# Heat simulation
This software models the change in heat across a 2-d space over time.

# Structure
A `make` command in the root directory will compile both C and Fortran versions of the simulation, while `make C` and `make Fortran` will compile each version respectively. A `make clean` command in the root directory will remove all created files except source code.

To run the executables built, you must include three arguments, in order: input file name, frequency of output file creation, and output file basename. 

Thanks for using this software!
