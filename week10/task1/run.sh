#!/bin/bash

module add gromacs:2022.3-plumed

# Set the number of CPUs and GPUs for the run
amssetenv -c 8 -g 1

# Compile topology information and coordinates to generate a tpr file
gmx grompp -f prod.mdp \
           -c equi.gro \
           -p system.top \
           -o prod.tpr

# Run the simulation
gmx mdrun -deffnm prod -ntomp ${INF_NCPUS} -v
