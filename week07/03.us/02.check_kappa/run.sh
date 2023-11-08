#!/bin/bash

i=1
for KAPPA in 200 600 800 1000 1200 1400
do
	i2d=`printf "%02d" "${i}"`
	cd ${i2d}.${KAPPA}
	for WIN in 35 36
	do
		cd ${WIN}
		psubmit gpu precycle_mdrun nnodes=1,ncpus=16,ngpus=2,mem=16gb,walltime=06:00:00 -y
		cd ..
	done
	i=$((i+1))
	cd ..
done
