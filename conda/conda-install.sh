#!/bin/bash -l

# delete existing if any
rm -rf ~/miniconda3/

# download and install Miniconda
mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-py311_23.5.1-0-Linux-x86_64.sh
bash Miniconda3-py311_23.5.1-0-Linux-x86_64.sh -b -u -p ~/miniconda3/
rm -rf Miniconda3-py311_23.5.1-0-Linux-x86_64.sh
