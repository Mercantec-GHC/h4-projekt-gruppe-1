package routes

import (
	"net/http"
	"net/http/httptest"
	"strings"
	"testing"

	"github.com/gin-gonic/gin"
)

func TestLogin(t *testing.T) {
	router := gin.Default()

	router.POST("/login")

	payload := strings.NewReader(`{"name": "John Doe1", "password": "password1"}`)
	req, _ := http.NewRequest("POST", "/login", payload)
	req.Header.Set("Content-Type", "application/json")

	recorder := httptest.NewRecorder()

	router.ServeHTTP(recorder, req)

	if status := recorder.Code; status != http.StatusOK {
		t.Errorf("handler returned wrong status code: got %v want %v", status, http.StatusOK)
	}

}
