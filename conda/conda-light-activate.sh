#!/bin/bash -l

# create the conda course environment
source /software/ncbr/softrepo/devel/anaconda3/2022.05/x86_64/para/bin/activate
conda create --prefix /scratch/$USER/conda_envs/c9555 -y
# conda create --name c9555 -y
source activate /scratch/$USER/conda_envs/c9555
# conda activate c9555

# install necessary components to the environment
conda config --add pkgs_dirs /scratch/$USER/conda_pkgs
conda install -c conda-forge python=3.7 jupyterlab=3.6.3 jupyterlab_widgets ipywidgets=8.1.0 -y

