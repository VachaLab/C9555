#!/bin/bash

init='system'
rest_prefix='system'
mini_prefix='step8_em'
equi_prefix='step%d_relaxation_solvent'


# Minimization
export OMP_NUM_THREADS=16
gmx grompp -f ${mini_prefix}.mdp -o ${mini_prefix}.tpr -c ${init}.gro -r ${rest_prefix}.gro -p topol.top -n index.ndx
gmx mdrun -v -deffnm ${mini_prefix}

# Equilibration
export OMP_NUM_THREADS=2
MPI_THREADS=8
cnt=8
cntmax=12

while [ $cnt -le $cntmax ]
do
    pcnt=$((cnt - 1))
    istep=`printf "${equi_prefix}" $cnt`
    pstep=`printf "${equi_prefix}" $pcnt`

    if [ $cnt -eq 1 ]
    then
        pstep="${mini_prefix}"
    fi
    
    if [ $cnt -eq 8 ]
    then
	    gmx grompp -f "${istep}.mdp" -o "${istep}.tpr" -c "${mini_prefix}.gro" -r "${rest_prefix}.gro" -p topol.top -n index.ndx -maxwarn 1
    else
	    gmx grompp -f "${istep}.mdp" -o "${istep}.tpr" -c "${pstep}.gro" -r "${rest_prefix}.gro" -p topol.top -n index.ndx -maxwarn 1
    fi
    mpirun -np ${MPI_THREADS} gmx_mpi mdrun -v -ntomp ${OMP_NUM_THREADS} -nb gpu -pme gpu -npme 1 -bonded cpu -deffnm "${istep}"
    cnt=$((cnt + 1))
done

