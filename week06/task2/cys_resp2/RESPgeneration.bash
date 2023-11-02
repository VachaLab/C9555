#!/bin/bash

espgen -i cys_hf.log -o cys.esp

antechamber -i cys_hf.log -fi gout -o cys.ac -fo ac

respgen -i cys.ac -o cys.resp1in -f resp1 -a cys.respadd

mv QIN cys.resp1chgin

respgen -i cys.ac -o cys.resp2in -f resp2 -a cys.respadd

rm QIN

resp -O -i cys.resp1in -o cys.resp1out -e cys.esp -t cys.resp1chg -q cys.resp1chgin

resp -O -i cys.resp2in -o cys.resp2out -e cys.esp -t cys.resp2chg -q cys.resp1chg

antechamber -i cys.ac -fi ac -o cys.mol2 -fo mol2 -c rc -cf cys.resp2chg

rm A*
rm esout
rm punch

