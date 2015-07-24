# Heat simulation
This software models the change in heat across a 2-d space over time.

# Compiling
- `make`  will compile both C and Fortran versions of the simulation.
- `make C` and `make Fortran` will compile each version respectively.
- `make figures` will plot the results of the simulation.
- `make clean` will remove all created files except source code.

# Running the simulation
To run the executables built, you must include three arguments, in order: input file name, frequency of output file creation, and output file basename.

# Notes
Thanks for using this software! This was my first foray into C/Fortran, so it might be a bit buggy. Feel free to submit pull requests and/or other feedback.
