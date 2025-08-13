package questions

import (
	"fmt"
	"math/rand"
	"time"
	"strconv"
)

type Question struct {
	Prompt	string
	Answer  string
}

type Generator struct {
	rnd *rand.Rand
}

func New(seed ...int64) *Generator {
	var s int64
	if len(seed) > 0 {
		s = seed[0]
	} else {
		s = time.Now().UnixNano()
	}

	return &Generator{rnd: rand.New(rand.NewSource(s))}
}

func (g *Generator) Generate() Question {
	a := g.rnd.Intn(100) + 1
	b := g.rnd.Intn(100) + 1
	ans := a + b
	return Question{Prompt: fmt.Sprintf("What is %d + %d?", a, b), Answer: strconv.Itoa(ans)}
}