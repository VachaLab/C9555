#!/bin/bash

module add gromacs:2022.3-plumed

# remove files from previous runs
rm -f COLS HIST* core bck.*

# run trajectory analysis
plumed driver --plumed data/plumed_1.dat --mf_xtc data/prod.xtc
