package util

import (
	"fmt"
	"os"
	"time"

	"github.com/golang-jwt/jwt"
	"github.com/joho/godotenv"
)

func CreateToken(name string, email string, phone string, username string, id uint) (string, error) {
	godotenv.Load()

	var secretKey = []byte(os.Getenv("SECRET_KEY"))

	claims := jwt.NewWithClaims(jwt.SigningMethodHS256, jwt.MapClaims{
		"sub":      name,
		"email":    email,
		"username": username,
		"phone":    phone,
		"iss":      "token-auth",
		"exp":      time.Now().Add(time.Hour * 24).Unix(),
		"iat":      time.Now().Unix(),
		"id":       id,
	})

	tokenString, err := claims.SignedString(secretKey)
	if err != nil {
		return "", err
	}

	fmt.Printf("Token claims added: %+v\n", claims)

	return tokenString, nil
}
