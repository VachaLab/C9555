#!/bin/bash

# calculate the histogram using the cats module
module add cats

histogram COLS HIST_CATS -l -0.5 -r 0.5 -c 2 -s 11 -n --nbins 100

# calculate the histogram using python
module add anaconda3

python '-' << EOF
import numpy as np

# read the data
with open('COLS', 'r') as cols:
    data = []

    for line in cols:
        if line.startswith('#'):
            continue

        val = float(line.split()[1])
        data.append(val)

# calculate the histogram
hist, bin_edges = np.histogram(data, bins=100, range=(-0.5,0.5), density=True)

# calculate midpoints of bins
midpoints = (bin_edges[:-1] + bin_edges[1:]) / 2

# write the output
with open('HIST_PYTH', 'w') as out:
    for x, y in zip(midpoints, hist):
        out.write(f'{x:8.3f} {y:8.3f}\n')
EOF
