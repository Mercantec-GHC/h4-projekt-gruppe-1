package util

import (
	"fmt"
	"time"

	"github.com/golang-jwt/jwt"
)

var secretKey = []byte("your-secret-key")

func CreateToken(name string, email string, phone string, username string, id uint) (string, error) {
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

/*func CreateRefreshToken(id uint) (string, error) {
	refreshClaims := jwt.NewWithClaims(jwt.SigningMethodHS256, jwt.MapClaims{
		"id":  id,
		"exp": time.Now().Add(time.Hour * 24 * 7).Unix(),
		"iat": time.Now().Unix(),
	})

	refreshTokenString, err := refreshClaims.SignedString(secretKey)
	if err != nil {
		return "", err
	}

	return refreshTokenString, nil
}*/
