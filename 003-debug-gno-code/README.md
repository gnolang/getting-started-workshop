# Debugging Gno code

In this section, you will learn to debug your Gno contract. As contracts aren't
modifiable, it is crucial to debug them properly before their publication to
the blockchain.

As you will see Gno debugging is pretty much the same as Go debugging.

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
