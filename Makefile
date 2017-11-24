execs = fib-c fib-c++ fib-chapel fib-d fib-d-ldc fib-crystal fib-go fib-felix fib-nim fib-rust fib-swift fib-ocaml fib-nuitka fib-fortran fib-pony
classes = java1.6/FibJava.class java1.7/FibJava.class java1.8/FibJava.class fib_scala.class
php5 = /usr/local/Cellar/php56/5.6.29_5/bin/php
php7 = /usr/local/Cellar/php71/7.1.0_11/bin/php

all: $(execs) $(classes)

binary: $(execs)
	file $(execs)
	otool -L $(execs)
	ls -l $(execs) | awk '{print $$5, $$9}' | sort -n
#	lipo -info $(execs)

check_num = 26
vvlow  = `seq $(check_num)`
vlow  = `seq 31`
low  = `seq 34`
mid  = `seq 40`
high = `seq 42`

bench: $(execs) $(classes)
	for i in $(vvlow); do 2>&1 time perl6 fib.pl6      $$i | tail -n 1 | awk '{print $$1}'; done

	for i in $(vlow); do 2>&1 time Rscript fib.R      $$i | tail -n 1 | awk '{print $$1}'; done
	for i in $(vlow); do 2>&1 time perl fib.pl        $$i | tail -n 1 | awk '{print $$1}'; done
	for i in $(vlow); do 2>&1 time awk -f fib.awk     $$i | tail -n 1 | awk '{print $$1}'; done
	for i in $(vlow); do 2>&1 time python fib.py      $$i | tail -n 1 | awk '{print $$1}'; done

	for i in $(low); do 2>&1 time $(php5) -f fib.php     $$i | tail -n 1 | awk '{print $$1}'; done
	for i in $(low); do 2>&1 time lua fib.lua        $$i | tail -n 1 | awk '{print $$1}'; done
	for i in $(low); do 2>&1 time ./fib-nuitka       $$i | tail -n 1 | awk '{print $$1}'; done
	for i in $(low); do 2>&1 time ruby fib.rb        $$i | tail -n 1 | awk '{print $$1}'; done
	for i in $(low); do 2>&1 time $(php7) -f fib.php     $$i | tail -n 1 | awk '{print $$1}'; done
	for i in $(low); do 2>&1 time elixir fib.exs     $$i | tail -n 1 | awk '{print $$1}'; done

	for i in $(mid); do 2>&1 time pypy fib.py $$i | tail -n 1 | awk '{print $$1}'; done
	for i in $(mid); do 2>&1 time node fib.js        $$i | tail -n 1 | awk '{print $$1}'; done
	for i in $(mid); do 2>&1 time luajit -O3 fib.lua $$i | tail -n 1 | awk '{print $$1}'; done
	for i in $(mid); do 2>&1 time julia -O3 fib.jl   $$i | tail -n 1 | awk '{print $$1}'; done
	for i in $(mid); do 2>&1 time scala fib.scala    $$i | tail -n 1 | awk '{print $$1}'; done
	for i in $(mid); do 2>&1 time swift fib.swift    $$i | tail -n 1 | awk '{print $$1}'; done
	for i in $(mid); do 2>&1 time ./fib-d            $$i | tail -n 1 | awk '{print $$1}'; done
	for i in $(mid); do 2>&1 time ./fib-fortran      $$i | tail -n 1 | awk '{print $$1}'; done
	for i in $(mid); do 2>&1 time ./fib-felix        $$i | tail -n 1 | awk '{print $$1}'; done
	for i in $(mid); do 2>&1 time ./fib-pony         $$i | tail -n 1 | awk '{print $$1}'; done
	for i in $(mid); do 2>&1 time ./fib-go           $$i | tail -n 1 | awk '{print $$1}'; done
	for i in $(mid); do 2>&1 time go run fib.go      $$i | tail -n 1 | awk '{print $$1}'; done
	for i in $(mid); do 2>&1 time ./fib-d-ldc        $$i | tail -n 1 | awk '{print $$1}'; done

	for i in $(high); do 2>&1 time scala fib_scala   $$i | tail -n 1 | awk '{print $$1}'; done
	for i in $(high); do 2>&1 time ./fib-chapel   --n=$$i | tail -n 1 | awk '{print $$1}'; done
	for i in $(high); do 2>&1 time ./fib-crystal      $$i | tail -n 1 | awk '{print $$1}'; done
	for i in $(high); do 2>&1 time ./fib-rust         $$i | tail -n 1 | awk '{print $$1}'; done
	for i in $(high); do 2>&1 time ./fib-nim          $$i | tail -n 1 | awk '{print $$1}'; done
	for i in $(high); do 2>&1 time ./fib-c            $$i | tail -n 1 | awk '{print $$1}'; done
	for i in $(high); do 2>&1 time ./fib-c++          $$i | tail -n 1 | awk '{print $$1}'; done
	for i in $(high); do 2>&1 time ./fib-ocaml        $$i | tail -n 1 | awk '{print $$1}'; done
	for i in $(high); do 2>&1 time ./fib-swift        $$i | tail -n 1 | awk '{print $$1}'; done
	for i in $(high); do 2>&1 time `/usr/libexec/java_home -v1.6`/bin/java -cp java1.6 FibJava $$i | tail -n 1 | awk '{print $$1}'; done
	for i in $(high); do 2>&1 time `/usr/libexec/java_home -v1.7`/bin/java -cp java1.7 FibJava $$i | tail -n 1 | awk '{print $$1}'; done
	for i in $(high); do 2>&1 time `/usr/libexec/java_home -v1.8`/bin/java -cp java1.8 FibJava $$i | tail -n 1 | awk '{print $$1}'; done

check: $(execs) $(classes)
	/usr/bin/time python ./fib.py      $(check_num)
	/usr/bin/time ruby ./fib.rb        $(check_num)
	/usr/bin/time swift ./fib.swift    $(check_num)
	/usr/bin/time Rscript ./fib.R      $(check_num)
	/usr/bin/time perl ./fib.pl        $(check_num)
	/usr/bin/time perl6 ./fib.pl6      $(check_num)
	/usr/bin/time $(php5) -f ./fib.php $(check_num)
	/usr/bin/time $(php7) -f ./fib.php $(check_num)
	/usr/bin/time ./fib-nuitka         $(check_num)
	/usr/bin/time elixir ./fib.exs     $(check_num)
	/usr/bin/time awk -f fib.awk       $(check_num)
	/usr/bin/time `/usr/libexec/java_home -v1.6`/bin/java -cp java1.6 FibJava $(check_num)
	/usr/bin/time `/usr/libexec/java_home -v1.7`/bin/java -cp java1.7 FibJava $(check_num)
	/usr/bin/time `/usr/libexec/java_home -v1.8`/bin/java -cp java1.8 FibJava $(check_num)

	/usr/bin/time pypy ./fib.py        $(check_num)
	/usr/bin/time lua ./fib.lua        $(check_num)
	/usr/bin/time luajit ./fib.lua     $(check_num)
	/usr/bin/time node ./fib.js        $(check_num)
	/usr/bin/time julia ./fib.jl       $(check_num)

	/usr/bin/time ./fib-c              $(check_num)
	/usr/bin/time ./fib-c++            $(check_num)
	/usr/bin/time ./fib-chapel     --n=$(check_num)
	/usr/bin/time ./fib-d              $(check_num)
	/usr/bin/time ./fib-d-ldc          $(check_num)
	/usr/bin/time ./fib-crystal        $(check_num)
	/usr/bin/time ./fib-go             $(check_num)
	/usr/bin/time ./fib-felix          $(check_num)
	/usr/bin/time ./fib-ocaml          $(check_num)
	/usr/bin/time ./fib-pony           $(check_num)
	/usr/bin/time ./fib-rust           $(check_num)
	/usr/bin/time ./fib-nim            $(check_num)
	/usr/bin/time ./fib-swift          $(check_num)
	/usr/bin/time ./fib-fortran        $(check_num)
	/usr/bin/time scala fib.scala      $(check_num)
	/usr/bin/time scala fib_scala      $(check_num)

memory: $(execs) $(classes)
	2>&1 /usr/bin/time -l python ./fib.py      $(check_num) | awk '/maximum resident set size/{ print $$1 }'
	2>&1 /usr/bin/time -l ruby ./fib.rb        $(check_num) | awk '/maximum resident set size/{ print $$1 }'
	2>&1 /usr/bin/time -l swift ./fib.swift    $(check_num) | awk '/maximum resident set size/{ print $$1 }'
	2>&1 /usr/bin/time -l Rscript ./fib.R      $(check_num) | awk '/maximum resident set size/{ print $$1 }'
	2>&1 /usr/bin/time -l perl ./fib.pl        $(check_num) | awk '/maximum resident set size/{ print $$1 }'
	2>&1 /usr/bin/time -l perl6 ./fib.pl6      $(check_num) | awk '/maximum resident set size/{ print $$1 }'
	2>&1 /usr/bin/time -l $(php5) -f ./fib.php $(check_num) | awk '/maximum resident set size/{ print $$1 }'
	2>&1 /usr/bin/time -l $(php7) -f ./fib.php $(check_num) | awk '/maximum resident set size/{ print $$1 }'
	2>&1 /usr/bin/time -l ./fib-nuitka         $(check_num) | awk '/maximum resident set size/{ print $$1 }'
	2>&1 /usr/bin/time -l elixir ./fib.exs     $(check_num) | awk '/maximum resident set size/{ print $$1 }'
	2>&1 /usr/bin/time -l awk ./fib.awk        $(check_num) | awk '/maximum resident set size/{ print $$1 }'
	2>&1 /usr/bin/time -l `/usr/libexec/java_home -v1.6`/bin/java -cp java1.6 FibJava $(check_num) | awk '/maximum resident set size/{ print $$1 }'
	2>&1 /usr/bin/time -l `/usr/libexec/java_home -v1.7`/bin/java -cp java1.7 FibJava $(check_num) | awk '/maximum resident set size/{ print $$1 }'
	2>&1 /usr/bin/time -l `/usr/libexec/java_home -v1.8`/bin/java -cp java1.8 FibJava $(check_num) | awk '/maximum resident set size/{ print $$1 }'

	2>&1 /usr/bin/time -l pypy ./fib.py        $(check_num) | awk '/maximum resident set size/{ print $$1 }'
	2>&1 /usr/bin/time -l lua ./fib.lua        $(check_num) | awk '/maximum resident set size/{ print $$1 }'
	2>&1 /usr/bin/time -l luajit ./fib.lua     $(check_num) | awk '/maximum resident set size/{ print $$1 }'
	2>&1 /usr/bin/time -l node ./fib.js        $(check_num) | awk '/maximum resident set size/{ print $$1 }'
	2>&1 /usr/bin/time -l julia ./fib.jl       $(check_num) | awk '/maximum resident set size/{ print $$1 }'

	2>&1 /usr/bin/time -l ./fib-c              $(check_num) | awk '/maximum resident set size/{ print $$1 }'
	2>&1 /usr/bin/time -l ./fib-c++            $(check_num) | awk '/maximum resident set size/{ print $$1 }'
	2>&1 /usr/bin/time -l ./fib-chapel     --n=$(check_num) | awk '/maximum resident set size/{ print $$1 }'
	2>&1 /usr/bin/time -l ./fib-d              $(check_num) | awk '/maximum resident set size/{ print $$1 }'
	2>&1 /usr/bin/time -l ./fib-d-ldc          $(check_num) | awk '/maximum resident set size/{ print $$1 }'
	2>&1 /usr/bin/time -l ./fib-crystal        $(check_num) | awk '/maximum resident set size/{ print $$1 }'
	2>&1 /usr/bin/time -l ./fib-go             $(check_num) | awk '/maximum resident set size/{ print $$1 }'
	2>&1 /usr/bin/time -l ./fib-felix          $(check_num) | awk '/maximum resident set size/{ print $$1 }'
	2>&1 /usr/bin/time -l ./fib-ocaml          $(check_num) | awk '/maximum resident set size/{ print $$1 }'
	2>&1 /usr/bin/time -l ./fib-pony           $(check_num) | awk '/maximum resident set size/{ print $$1 }'
	2>&1 /usr/bin/time -l ./fib-rust           $(check_num) | awk '/maximum resident set size/{ print $$1 }'
	2>&1 /usr/bin/time -l ./fib-nim            $(check_num) | awk '/maximum resident set size/{ print $$1 }'
	2>&1 /usr/bin/time -l ./fib-swift          $(check_num) | awk '/maximum resident set size/{ print $$1 }'
	2>&1 /usr/bin/time -l ./fib-fortran        $(check_num) | awk '/maximum resident set size/{ print $$1 }'
	2>&1 /usr/bin/time -l scala fib.scala      $(check_num) | awk '/maximum resident set size/{ print $$1 }'
	2>&1 /usr/bin/time -l scala fib_scala      $(check_num) | awk '/maximum resident set size/{ print $$1 }'

version:
	2>&1 sw_vers
	2>&1 clang --version | head -n 1
	2>&1 chpl --version | head -n 1
	2>&1 crystal --version
	2>&1 go version
	2>&1 flx --version
	2>&1 elixir --version
	2>&1 nim --version | head -n 1
	2>&1 julia --version
	2>&1 rustc --version
	2>&1 swift --version
	2>&1 swiftc --version | head -n 1
	2>&1 luajit -v
	2>&1 lua -v
	2>&1 pypy --version | tail -n 1
	2>&1 python --version
	2>&1 Rscript --version
	2>&1 perl -v | head -n 2 | tail -n 1
	2>&1 perl6 -v | head -n 2 | tail -n 1
	2>&1 $(php5) --version | head -n 1
	2>&1 $(php7) --version | head -n 1
	2>&1 ocaml -version
	2>&1 nuitka --version
	2>&1 node --version
	2>&1 ruby --version
	2>&1 ponyc --version
	2>&1 dmd --version | head -n 1
	2>&1 ldc2 --version | head -n 1
	2>&1 awk --version |head -n 1
	2>&1 `/usr/libexec/java_home -v1.6`/bin/java -cp java1.6 -version
	2>&1 `/usr/libexec/java_home -v1.7`/bin/java -cp java1.7 -version
	2>&1 `/usr/libexec/java_home -v1.8`/bin/java -cp java1.8 -version
	2>&1 gfortran --version |head -n 1
	2>&1 scala -version
	2>&1 scalac -version

fib-c: fib.c
	time clang -Ofast -o fib-c $<

fib-c++: fib.cc
	time clang++ -Ofast -o fib-c++ $<

fib-chapel: fib.chpl
	time chpl -O -o fib-chapel $<

fib-d: fib.d
	time dmd -m64 -release -O -offib-d $<

fib-d-ldc: fib.d
	time ldc2 -L=-w -O5 -m64 -offib-d-ldc $<

fib-crystal: fib.rb
	time crystal build --link-flags -L/usr/local/lib --release -o fib-crystal $<

fib-go: fib.go
	time go build -o fib-go $<

fib-felix: fib.flx
	time flx --static -c -O3 -o fib-felix $<

fib-nim: fib.nim
	time nim c --verbosity:0 -d:release --app:console --opt:speed --out:fib-nim $<

fib-ocaml: fib.ml
	time ocamlopt -o fib-ocaml $<

fib-pony: fib.pony
	time ponyc -o fib-pony.tmp
	mv fib-pony.tmp/fibonacci-benchmark fib-pony

fib-rust: fib.rs
	time rustc -O -o fib-rust $<

fib-swift: fib.swift
	time swiftc -sdk `xcrun --show-sdk-path --sdk macosx` -O -o fib-swift $<

fib-nuitka: fib.py
	time nuitka --clang fib.py
	mv fib.exe fib-nuitka

java1.6/FibJava.class: FibJava.java
	mkdir -p java1.6
	time `/usr/libexec/java_home -v1.6`/bin/javac FibJava.java -d java1.6

java1.7/FibJava.class: FibJava.java
	mkdir -p java1.7
	time `/usr/libexec/java_home -v1.7`/bin/javac FibJava.java -d java1.7

java1.8/FibJava.class: FibJava.java
	mkdir -p java1.8
	time `/usr/libexec/java_home -v1.8`/bin/javac FibJava.java -d java1.8

fib_scala.class: fib.scala
	time scalac $<

fib-fortran: fib.f90
	time gfortran $< -o fib-fortran

clean:
	rm -f $(execs) *.o *~ flxg_stats.txt fib_scala* $(classes)
	rm -fr nimcache
	rm -fr fib.build
	rm -fr .crystal
	rm -fr fib.cm[ix]
	rm -fr fib-pony.tmp
	rm -fr fib-fortran
	rm -fr java1.6
	rm -fr java1.7
	rm -fr java1.8
