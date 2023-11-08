#!/bin/bash

for WIN in {1..71}
do
	WIN_2D=`printf "%02d" "${WIN}"`
	mkdir ../${WIN_2D}
	cp -pr ./{topol.top,index.ndx,toppar,win-${WIN_2D}.gro} ../${WIN_2D}/
	#sed "s/<WIN>/win-${WIN_2D}.gro/g" precycle_mdrun > ../${WIN_2D}/precycle_mdrun
	CV=`echo "3.5-$((WIN-1))*0.1" | bc`
	sed "s/<CV>/${CV}/g" step15_us.mdp > ../${WIN_2D}/step15_us.mdp
done
