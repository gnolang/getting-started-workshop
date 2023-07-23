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

- `queue.gno`, in this tutorial's directory `003-debug-gno-code`, is a source file containing 2 stub functions `Push` and `Pop`. Your goal in this tutorial is to implement them correctly and see the tests succeed.
- `queue_test.gno` contains a test that checks the behavior of `Pop` and `Push`.
  If you implement them correctly, running `gno test` will succeed without errors.

## Steps

- Run the test:
```
$ gno test . -verbose
```
The test will fail, because `Pop` and `Push` are currently not
implemented -- if you open the `queue.gno` file, you will see
that they just contain two `// TODO` comments.

- Implement `Pop` and `Push`. These need to implement a
  FIFO (First In, First Out) queue -- so the last element added
  using `Push` will be the first one to be removed using `Pop`.
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
