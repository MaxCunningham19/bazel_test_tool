package quiz

import (
	"quiz/questions"
)

type AnswerFunction func(str string) string

type Quiz struct {
	score int64
	question_number int64
	generator *questions.Generator
	answerFunction AnswerFunction
}

func New(answerFunc AnswerFunction, seed ...int64) *Quiz {
	return &Quiz{score: 0, question_number: 0, answerFunction: answerFunc, generator: questions.New(seed...)}
}

func (q *Quiz) AskQuestion() bool {
	q.question_number += 1
	question := q.generator.Generate()
	ans := q.answerFunction(question.Prompt)
	if (ans == question.Answer) {
		q.score += 1
	}
	return ans == question.Answer
}

func (q *Quiz) Score() (int64, int64) {
	return q.score, q.question_number
}