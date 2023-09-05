#!/bin/bash -l

# initialize conda and create the course environment
source ~/miniconda3/bin/activate
conda create --name c9555 -y
conda activate c9555

# install necessary components to the environment
conda install -c conda-forge gromacswrapper python=3.11 mdanalysis jupyterlab=3.6.3 jupyterlab_widgets ipywidgets=8.1.0 nodejs scipy -y

# activate jupyter
jupyter lab build
# screen -S lesson 
jupyter lab --no-browser
