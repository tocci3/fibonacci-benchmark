# fibonacci-benchmark

for mac

## brew, cask, pip

    brew install ocaml crystal-lang luajit node elixir dmd pypy ponyc chapel nimrod go ldc
    brew install scala Caskroom/versions/java6 Caskroom/versions/java7 perl6 R
    brew install homebrew/php/php56
    brew unlink homebrew/php/php56
    brew install homebrew/php/php71
    brew cask install julia
    pip install nuitka

## manual install

# (brew) * nim (http://nim-lang.org/download.html)
# (brew) * rust (https://www.rust-lang.org/downloads.html)

## felix

https://groups.google.com/forum/#!topic/felix-language/jQJOy_ovPFc

    brew install ocaml python3
    git clone https://github.com/felix-lang/felix.git
    cd felix
    git checkout 2b4c4a7
    export PATH=build/release/host/bin:$PATH
    export LD_LIBRARY_PATH=build/release/host/lib/rtl:$LD_LIBRARY_PATH
    export DYLD_LIBRARY_PATH=build/release/host/lib/rtl:$DYLD_LIBRARY_PATH
    make build && make install


## check
    make check


## benchmark
    ./bench.sh

