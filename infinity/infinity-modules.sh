#!/bin/bash -l

echo -e "2\n3\ngromacs:2022.3-plumed\ngnuplot:5.4.2\nvmd:1.9.3\nanaconda3:2022.05\n\nq\nq\nyes\n" > input-prompt
ams-config < input-prompt
rm -rf input-prompt
bash
