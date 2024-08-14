package routes

import (
    "bytes"
    "encoding/json"
    "net/http"
    "net/http/httptest"
    "testing"
    "token-auth/models"

    "github.com/gin-gonic/gin"
    "github.com/stretchr/testify/assert"
)

func setupRouter() *gin.Engine {
    r := gin.Default()
    r.POST("/register", Register)
    return r
}

func TestRegister(t *testing.T) {
    router := setupRouter()

    tests := []struct {
        name           string
        payload        models.User
        expectedStatus int
    }{
        {
            name: "Valid user",
            payload: models.User{
                Name:         "John Doe",
                NickName:     "Johnny",
                Email:        "johndoe@example.com",
                Password:     "securepassword",
                Phone:        "12345678",
                ProfilePhoto: "profilepic.jpg",
                StatsId:      "",
            },
            expectedStatus: http.StatusCreated,
        },
        {
            name: "Invalid user (missing name)",
            payload: models.User{
                NickName:     "Johnny",
                Email:        "johndoe@example.com",
                Password:     "securepassword",
                Phone:        "12345678",
            },
            expectedStatus: http.StatusBadRequest,
        },
    }

    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            payload, err := json.Marshal(tt.payload)
            if err != nil {
                t.Fatalf("Failed to marshal payload: %v", err)
            }
            req, err := http.NewRequest("POST", "/register", bytes.NewBuffer(payload))
            if err != nil {
                t.Fatalf("Failed to create request: %v", err)
            }
            req.Header.Set("Content-Type", "application/json")

            resp := httptest.NewRecorder()
            router.ServeHTTP(resp, req)

            assert.Equal(t, tt.expectedStatus, resp.Code)
        })
    }
}