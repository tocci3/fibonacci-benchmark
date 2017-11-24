public class FibJava {
    static int fib(int n) {
//        if (n < 2) return n;
//        return fib(n - 2) + fib(n - 1);
        return n < 2 ? n : fib(n - 2) + fib(n - 1);
    }

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		System.out.println(fib(Integer.valueOf(args[0])));
	}

}
