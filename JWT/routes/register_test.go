package routes

import (
	"net/http"
	"net/http/httptest"
	"strings"
	"testing"

	"github.com/gin-gonic/gin"
)

func TestRegister(t *testing.T) {
	router := gin.Default()

	router.POST("/register", Register)

	payload := strings.NewReader(`{	"name": "John Doe",	"nick_name": "JD",	"email": "johndoe@example.com",	"password": "password123",	"phone": "123-456-7890",	"profile_photo": "http://example.com/profile.jpg",	"stats_id": "12345"}`)
	req, _ := http.NewRequest("POST", "/register", payload)
	req.Header.Set("Content-Type", "application/json")

	recorder := httptest.NewRecorder()
	router.ServeHTTP(recorder, req)

	if status := recorder.Code; status != http.StatusCreated {
		t.Errorf("handler returned wrong status code: got %v want %v", status, http.StatusCreated)
	}

	expected := `{"message":"User registered"}`
	if body := recorder.Body.String(); strings.TrimSpace(body) != expected {
		t.Errorf("handler returned unexpected body: got %v want %v", body, expected)
	}
}