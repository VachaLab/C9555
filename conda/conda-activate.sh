#!/bin/bash -l

# create the conda course environment
source /software/ncbr/softrepo/devel/anaconda3/2022.05/x86_64/para/bin/activate
conda env create -f ../conda/c9555.yml -p /scratch/$USER/conda_envs/c9555
