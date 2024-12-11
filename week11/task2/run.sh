#!/bin/bash

module add gromacs:2022.3-plumed

amssetenv -c 2 -g 1

gmx grompp -f martini_v2.x_new-rf.mdp -o prod.tpr -c equi.gro -n index.ndx -p topol.top -maxwarn 1

gmx mdrun -deffnm prod -ntomp ${INF_NCPUS} -v -plumed plumed.dat
