package queue

import "testing"

func TestQueue(t *testing.T) {
	// Push 2 items
	Push("alice")
	Push("bob")
	// Call Pop() 3 times
	// Third time should return an empty string because the queue is empty
	for i, expected := range []string{"alice", "bob", ""} {
		res := Pop()
		if res != expected {
			t.Errorf("Pop()#%d want %q, got %q", i, expected, res)
		}
	}
}
