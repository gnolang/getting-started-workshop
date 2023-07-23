package hello

import "testing"

func TestSum(t *testing.T) {
	got := Sum(1, 2)
	expected := 3
	if got != expected {
		t.Errorf("expected %d, got %d", expected, got)
	}
}
