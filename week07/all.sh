#!/bin/bash

for i in {1..6}
do
	rm -rf ../week0${i}
	. ../infinity/infinity-temp.sh
	. ../conda/conda-activate.sh
	. ../conda/jupyter-start.sh
done

