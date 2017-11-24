<?php
function fib($n) {
	return $n < 2 ? $n : fib($n - 1) + fib($n - 2);
}
print fib((int)($argv[1])) . "\n";
