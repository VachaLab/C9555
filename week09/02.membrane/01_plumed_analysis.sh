#!/bin/bash

module add gromacs:2022.3-plumed

# remove files from previous runs
rm -f COLS* core bck.*

# run trajectory analysis
plumed driver --plumed data/plumed.dat --mf_xtc data/prod.xtc
