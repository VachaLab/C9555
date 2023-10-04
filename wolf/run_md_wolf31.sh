#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Please, specify name of .tpr file"
    exit 1
fi

filename="run.sh"
simname=$1

cat > $filename << EOL
#!/bin/bash
module add gromacs:2022.3-plumed
gmx mdrun -deffnm $simname -v -cpi $simname.cpt
exit
EOL

psubmit default run.sh -y ncpus=16 ngpus=0 mem=125gb walltime=1d props=gr_compnode
