package util

import (
	"fmt"
	"time"

	"github.com/golang-jwt/jwt"
)

var secretKey = []byte("your-secret-key")

func CreateToken(username string, email string, name string, phone string) (string, error) {
	claims := jwt.NewWithClaims(jwt.SigningMethodHS256, jwt.MapClaims{
		"sub":   username,
		"name":  name,
		"email": email,
		"phone": phone,
		"iss":   "token-auth",
		"exp":   time.Now().Add(time.Hour * 24).Unix(),
		"iat":   time.Now().Unix(),
	})

	tokenString, err := claims.SignedString(secretKey)
	if err != nil {
		return "", err
	}

	fmt.Printf("Token claims added: %+v\n", claims)
	return tokenString, nil
}
