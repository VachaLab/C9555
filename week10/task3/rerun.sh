#!/bin/bash

module add gromacs:2022.3-plumed

# Set the number of CPUs and GPUs for the run
amssetenv -c 8 -g 1

# Compile topology information and coordinates to generate a tpr file
gmx grompp -f rerun.mdp \
           -c equi.gro \
           -n index.ndx \
           -p topol.top \
           -o rerun.tpr

# Run the simulation
gmx mdrun -deffnm rerun -rerun pull.xtc
