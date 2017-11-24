#!/bin/bash
## bench
dir=result/`date +%Y%m%d`_`uname -srpm |tr " " "_"`_`system_profiler SPHardwareDataType |egrep "Processor|Core" |sed -e 's/^.*:[ \t]*//' -e 's/ /_/g' |tr "\n" "-" |sed -e 's/-$//'`
mkdir -p $dir
make bench | tee $dir/bench.txt
./report.awk $dir/bench.txt |tee $dir/bench.csv
make version |tee $dir/version.txt
make memory |tee $dir/memory.txt
system_profiler SPHardwareDataType |egrep -v 'Serial Number \(system\): |Hardware UUID:' |tee $dir/SPHardwareDataType.txt
# To see the result in GUI
#open $dir/bench.csv
echo " To see the result in GUI: open $dir/bench.csv"

