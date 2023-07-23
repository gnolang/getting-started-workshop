package main

import queue "gno.land/r/demo/getting_started/003_debug_gno_code"

func main() {
	println(42, 44)
	_ = queue.Pop
}

// Output:
// 42 44
