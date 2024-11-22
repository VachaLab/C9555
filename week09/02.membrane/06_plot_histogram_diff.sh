#!/bin/bash

# calculate the histogram asymmetry
for i in WATER IONS WATER_MULTI IONS_MULTI; do
    awk '/#/ {next} $1 < 0 {print}' HIST_${i} | tac > a
    awk '/#/ {next} $1 > 0 {print}' HIST_${i} > b
    paste a b | awk '{print $3, $4-$2}' > HIST_${i}_DIFF

    # remove temporary files
    rm -f a b

done

# plot the data using gnuplot
gnuplot << EOF
set terminal pngcairo

set grid

set yrange [-8:8]

set xlabel "Scaled Distance"
set ylabel "Frequency"

set output "HIST_DIFF.png"
plot 'HIST_WATER_DIFF' u (\$1 < 0 ? -\$1 : \$1):2 w l lc rgb "dark-blue" t "Water", \
     'HIST_IONS_DIFF' u (\$1 < 0 ? -\$1 : \$1):2 w l lc rgb "dark-red" t "Sodium"

set output "HIST_MULTI_DIFF.png"
plot 'HIST_WATER_MULTI_DIFF' u (\$1 < 0 ? -\$1 : \$1):2 w l lc rgb "dark-blue" t "Water", \
     'HIST_IONS_MULTI_DIFF' u (\$1 < 0 ? -\$1 : \$1):2 w l lc rgb "dark-red" t "Sodium"
EOF

# show the images
display HIST_DIFF.png &
display HIST_MULTI_DIFF.png
