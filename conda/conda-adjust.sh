#!/bin/bash -l

source /software/ncbr/softrepo/devel/anaconda3/2022.05/x86_64/para/bin/activate

ENV_PATH="/scratch/$USER/conda_envs/c9555"

if [ -d "$ENV_PATH" ]; then
    source activate $ENV_PATH
    conda config --add pkgs_dirs /scratch/$USER/conda_pkgs
    # week02
    # conda install -c conda-forge matplotlib ipython -y
    # week03
    # conda install -c conda-forge matplotlib mdanalysis -y
    conda install -c conda-forge matplotlib -y
else
    echo "Environment does not exist. Should be installed from the beginning."
    exit 
fi
