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
gmx mdrun -nb gpu -pme gpu -deffnm $simname -cpi $simname.cpt -maxh 23
exit
EOL

psubmit default run.sh -y ncpus=24 ngpus=1 mem=120gb walltime=1d props=gr_compnode
