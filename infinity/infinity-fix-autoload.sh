#!/bin/bash -l

echo -e "2\n4\ngromacs:2022.3-plumed\nanaconda3:2022.05\n\nq\nq\nyes\n" > input-prompt
ams-config < input-prompt
rm -rf input-prompt
bash
