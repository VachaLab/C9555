#!/bin/bash

# plot the data using gnuplot
gnuplot << EOF
set terminal pngcairo
set output "HIST_SYMM.png"

set grid

set yrange [-1:9]

set xlabel "Scaled Distance"
set ylabel "Frequency"

plot 'HIST_WATER_MULTI' u (\$1 < 0 ? -\$1 : \$1):2 w l lc rgb "dark-blue" t "Water", \
     'HIST_IONS_MULTI' u (\$1 < 0 ? -\$1 : \$1):2 w l lc rgb "dark-red" t "Sodium"
EOF

# show the image
display HIST_SYMM.png
