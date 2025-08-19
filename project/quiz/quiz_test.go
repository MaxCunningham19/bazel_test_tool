package quiz


import (
	"testing"
)

func AnsIsTwelve(f string) string {
	return "94"
}


func TestSeededValue(t *testing.T) {
	qiz := New(AnsIsTwelve, 42)

	if !qiz.AskQuestion() {
		t.Errorf("Answer should be 94")
	}
}