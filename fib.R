fib <- function(n) {
    if (n < 2) return(n)
    return(fib(n - 2) + fib(n - 1))
}
print(fib(as.numeric(commandArgs(TRUE)[1])))
