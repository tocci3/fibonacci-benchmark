object fib_scala {
	def fib(n:Int):Int = {
		if (n < 2) n
		else fib(n - 2) + fib(n - 1)
	}

	def main(args: Array[String]):Unit = {
		println(fib(args(0).toInt));
	}
}
