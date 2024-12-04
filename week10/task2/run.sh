#!/bin/bash

module add gromacs:2022.3-plumed

# Set the number of CPUs and GPUs for the run
amssetenv -c 8 -g 1

# Compile topology information and coordinates to generate a tpr file
gmx grompp -f martini_v2.x_new-rf.mdp \
           -n index.ndx \
           -c equi.gro \
           -p topol.top \
           -o prod.tpr

# Run the simulation
gmx mdrun -deffnm prod -v

# Analyze a trajectory using PLUMED
if [ -f plumed.dat ]; then
    plumed driver --plumed plumed.dat --mf_xtc prod.xtc
fi
