#!/bin/bash
# module add gromacs:2022.3-plumed
# Default values for variables
BOX_SIZE_XY=7.5
BOX_SIZE_Z=7.5
NMOL=128
MAXSOL=$((10 * NMOL))
NOMP=4
MPI=1
GPU_ID=0
NB_CALC_MODE="gpu"
PME_CALC_MODE="auto"
BONDED_CALC_MODE="auto"

# Read new values from arguments (if provided)
while getopts "x:y:z:n:m:o:p:g:b:e:a:" opt; do
    case $opt in
        x) BOX_SIZE_XY="$OPTARG" ;;
        y) BOX_SIZE_Z="$OPTARG" ;;
        n) NMOL="$OPTARG" ;;
        m) MAXSOL="$OPTARG" ;;
        o) NOMP="$OPTARG" ;;
        p) MPI="$OPTARG" ;;
        g) GPU_ID="$OPTARG" ;;
        b) NB_CALC_MODE="$OPTARG" ;;
        e) PME_CALC_MODE="$OPTARG" ;;
        a) BONDED_CALC_MODE="$OPTARG" ;;
        \?) echo "Invalid option -$OPTARG" >&2 ;;
    esac
done

# Commands using the variables
gmx insert-molecules -ci DPPC-em.gro -box $BOX_SIZE_XY $BOX_SIZE_XY $BOX_SIZE_Z -nmol $NMOL -radius 0.21 -try 500 -o ${NMOL}_noW.gro 

# Prepare a simulation file
sed "s/REPLACE_NMOL/$NMOL/g" "dppcR.top" > "dppc.top"
gmx grompp -f minimization.mdp -c ${NMOL}_noW.gro -p dppc.top -o dppc-min-init.tpr

# Minimize the structure, basically look for overlaps in beads
gmx mdrun -deffnm dppc-min-init -v -c ${NMOL}_minimized.gro

# Fill the minimized simulation with water molecules
# It will try to fill in at most, 768 water beads
gmx solvate -cp ${NMOL}_minimized.gro -cs water.gro -o waterbox.gro -maxsol $MAXSOL -radius 0.21

# Now we have perturbed the simulation, so we will minimize it one more time
# Could this be done in fewer steps?
# Be aware that dppc_w.top has the number of water molecules in it
sed "s/REPLACE_NMOL/$NMOL/g" "dppc_wRnw.top" > "dppc_wRw.top"
sed "s/REPLACE_WATER/$MAXSOL/g" "dppc_wRw.top" > "dppc_w.top"
gmx grompp -f minimization.mdp -c waterbox.gro -p dppc_w.top -o dppc-min-solvent.tpr

# Minimize the structure
gmx mdrun -deffnm dppc-min-solvent -v -c minimized.gro

# Now we input the martini force-field
gmx grompp -f martini_md.mdp -c minimized.gro -p dppc_w.top -o dppc-md.tpr -maxwarn 1

# Setting the number of OpenMP threads
export OMP_NUM_THREADS=$NOMP

# Run the simulation with the specified number of MPI processes and OpenMP threads
mpirun -np $MPI gmx_mpi mdrun -ntomp $NOMP -gpu_id $GPU_ID -nb $NB_CALC_MODE -pme $PME_CALC_MODE -bonded $BONDED_CALC_MODE -nsteps 200000 -x dppc-md.xtc -c dppc-md.gro -s dppc-md.tpr
gmx trjconv -s dppc-md.tpr -f dppc-md.xtc -o dppc-md.pdb -pbc whole -conect 
