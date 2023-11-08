#!/bin/bash

for i in {001..009}
do
	mkdir ${i}
	cd ${i}
	cp -pr ../{md_prod000{1.gro,2.cpt},toppar,topol.top,index.ndx,precycle_mdrun} .
	case ${i} in
		"001")
                        RATE='0.01'
                        NSTEPS='250000'
				;;
		"002")
                        RATE='0.005'
                        NSTEPS='500000'
                ;;
		"003")
						RATE='0.002'
						NSTEPS='1250000'
                ;;
		"004")
						RATE='0.001'
						NSTEPS='1000000'
				;;
		"005")
                        RATE='0.0001'
                        NSTEPS='10000000'
                ;;
		"006")
                        RATE='0.00005'
                        NSTEPS='20000000'
                ;;
		"007")
                        RATE='0.00004'
                        NSTEPS='25000000'
                ;;
		"008")
                        RATE='0.000025'
                        NSTEPS='40000000'
                ;;
		"009")
                        RATE='0.00002'
                        NSTEPS='50000000'
                ;;
	esac
	sed "s/<NSTEPS>/${NSTEPS}/; s/<RATE>/${RATE}/g" ../step14_smd.mdp.template > step14_smd.mdp
	cd ..
done
