# Debugging Gno code

In this section, you will learn to debug your Gno contract. As contracts aren't
modifiable, it is crucial to debug them properly before their publication to
the blockchain.

Debugging Gno code functions in many ways as in Go;
the biggest tool at our disposal are test files. These are identified
as source files whose names end with `_test.go`. Every function of
the kind `func TestXxx(t *testing.T)` is automatically added as a test,
run when using `gno test`. If the function calls `t.Errorf`, then it is
considered failed.

- `queue.gno` in this section implements a basic FIFO queue with 2 functions
`Push` and `Pop`.
- `queue_test.gno` contains a test that asserts the expected behavior of `Pop` and
`Push`.

## Steps

- Run the test:
```
$ gno test . -verbose -run TestQueue
```
The test fails because `Pop` and `Push` are not implemented properly.

- Implement `Pop` and `Push`
- Run the test again until it succeeds 

<details>
    <summary>Solution (only if you're stuck!)</summary>

```go
func Push(s string) {
    q = append(q, s)
}

func Pop() string {
    if len(q) == 0 {
        return ""
    }
    s := q[0]
    q = q[1:]
    return s
}
```

</details>
