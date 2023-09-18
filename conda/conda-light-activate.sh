#!/bin/bash -l

# create the conda course environment
source /software/ncbr/softrepo/devel/anaconda3/2022.05/x86_64/para/bin/activate
conda create --name c9555 -y
conda activate c9555

# install necessary components to the environment
conda install -c conda-forge nglview python=3.7 mdanalysis jupyterlab=3.6.3 jupyterlab_widgets ipywidgets=8.1.0 nodejs scipy -y
# conda install -c conda-forge nglview gromacswrapper python=3.7 mdanalysis jupyterlab=3.6.3 jupyterlab_widgets ipywidgets=8.1.0 nodejs scipy -y
# conda install -c omnia openmm

# activate jupyter
jupyter lab build
jupyter lab --no-browser
