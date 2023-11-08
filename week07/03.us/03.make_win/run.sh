#!/bin/bash

for WIN in {01..72}
do
        cd ${WIN}
        psubmit gpu precycle_mdrun nnodes=1,ncpus=16,ngpus=2,mem=16gb,walltime=23:30:00 -y
        cd ..
done
~          
