#!/bin/bash

i=1
for KAPPA in 200 600 800 1000 1200 1400 1600 1800 2000 2200 2400 2600
do
	i2d=`printf "%02d" "${i}"`
	mkdir ${i2d}.${KAPPA}
	cd ${i2d}.${KAPPA}
	for WIN in 35 36
	do
		mkdir ${WIN}
		cd ${WIN}
		cv=`echo "3.5-$((WIN-1))*0.1" | bc`
		cp -pr ../../{topol.top,index.ndx,toppar,win-${WIN}.gro} .
		#sed "s/<WIN>/win-${WIN}.gro/g" ../../precycle_mdrun > precycle_mdrun
		sed "s/<CV>/${cv}/g; s/<KAPPA>/${KAPPA}/g" ../../step15_us_freq_save.mdp.template > step15_us_freq_save.mdp
		cd ..
	done
	i=$((i+1))
	cd ..
done
