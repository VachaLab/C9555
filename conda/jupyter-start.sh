#!/bin/bash -l

source /software/ncbr/softrepo/devel/anaconda3/2022.05/x86_64/para/bin/activate

source activate /scratch/$USER/conda_envs/c9555

# activate jupyter
jupyter lab build
jupyter lab --no-browser
