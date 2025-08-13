package questions

import (
	"fmt"
	"math/rand"
	"strconv"
	"strings"
	"testing"
)

func TestFlakyGenerate(t *testing.T) {
	seeds := []int64{42, 97}
	seed := seeds[rand.Intn(len(seeds))]

	gen := New(seed)
	q := gen.Generate()

	expected := Question{
		Prompt: "What is 6 + 88?", // example value; update if needed
		Answer: "94",
	}
	if q != expected {
		t.Errorf("Seed 42: expected %v, got %v", expected, q)
	}
}

// Deterministic generation with fixed seed
func TestGenerateDeterministic(t *testing.T) {
	gen := New(42)
	q1 := gen.Generate()
	q2 := gen.Generate()

	gen2 := New(42)
	r1 := gen2.Generate()
	r2 := gen2.Generate()

	if q1 != r1 || q2 != r2 {
		t.Errorf("Expected reproducible results, got q1=%v, q2=%v, r1=%v, r2=%v", q1, q2, r1, r2)
	}
}

// Check question format and correctness
func TestGenerateQuestionFormat(t *testing.T) {
	gen := New(123)
	q := gen.Generate()

	if !strings.HasPrefix(q.Prompt, "What is ") {
		t.Errorf("Prompt format incorrect: %s", q.Prompt)
	}

	var a, b int
	n, err := fmt.Sscanf(q.Prompt, "What is %d + %d?", &a, &b)
	if err != nil || n != 2 {
		t.Errorf("Failed to parse numbers from prompt: %s", q.Prompt)
	}

	expectedAnswer := strconv.Itoa(a + b)
	if q.Answer != expectedAnswer {
		t.Errorf("Expected answer %s, got %s", expectedAnswer, q.Answer)
	}
}

// Generate multiple questions to ensure valid ranges
func TestGenerateMultiple(t *testing.T) {
	gen := New()
	for i := 0; i < 1000; i++ {
		q := gen.Generate()
		var a, b int
		n, err := fmt.Sscanf(q.Prompt, "What is %d + %d?", &a, &b)
		if err != nil || n != 2 {
			t.Errorf("Failed to parse numbers in iteration %d: %s", i, q.Prompt)
		}
		if a < 1 || a > 100 || b < 1 || b > 100 {
			t.Errorf("Numbers out of expected range in iteration %d: a=%d, b=%d", i, a, b)
		}
		expectedAnswer := strconv.Itoa(a + b)
		if q.Answer != expectedAnswer {
			t.Errorf("Answer incorrect in iteration %d: expected %s, got %s", i, expectedAnswer, q.Answer)
		}
	}
}
