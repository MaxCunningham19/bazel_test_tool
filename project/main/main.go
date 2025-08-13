package main

import (
	"fmt"
	"quiz/quiz"
	"strings"
)

func AnswerQuestion(question string) string {
	fmt.Println(question)
	var answer string 
	fmt.Scanln(&answer)
	return answer
}


func main() {
	qiz := quiz.New(AnswerQuestion)
	var input string
	fmt.Println("Welcome to the maths game answer the questions correct to score points!")
	for {
		fmt.Print("Do you want to quit? [y|N] ")
		fmt.Scanln(&input)
		lower := strings.ToLower(input)
		if lower == "y" || lower == "yes" {
			break
		}
		if qiz.AskQuestion() {
			fmt.Println("Correct! Well Done!")
		} else {
			fmt.Println("Oooh, thats incorrect. Get the next one!")
		}
	}
	score, qs := qiz.Score()
	fmt.Printf("Thanks for playing\nFinal score: [%d/%d]\n", score, qs)
}


