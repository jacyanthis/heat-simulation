#!/bin/bash

for i in `ls *_*.dat`
do
  echo $i
  gnuplot -e "filename='$i'" -e "outfile='$i.png'" project.gplot
done
