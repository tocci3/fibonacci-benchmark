function fib(n) {
    return n < 2 ? n : fib(n - 2) + fib(n - 1)
}
BEGIN {
    printf "%d\n", fib(ARGV[1])
}

