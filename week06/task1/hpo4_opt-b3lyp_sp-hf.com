%mem=7000MB
%nproc=4
%chk=hpo4_b3lyp-opt
#B3LYP/6-31+G* opt scf=tight freq=NoRaman

hpo42-

-2 1
 


--Link1--
%mem=7000MB
%nproc=4
%chk=hpo4_b3lyp-opt
#P HF/6-31G* SCF=Tight Pop=(MK) IOp(6/33=2) Geom=check iop(6/50=1)

hpo42-

-2 1

hpo4.gesp




