package util

import (
	"fmt"
	"os"
	"time"

	"github.com/golang-jwt/jwt"
	"github.com/joho/godotenv"
)

func CreateRefreshToken(name string, id uint) (string, error) {
	godotenv.Load()

	var secretKey = []byte(os.Getenv("SECRET_KEY"))

	refreshToken := jwt.New(jwt.SigningMethodHS256)
	rtClaims := refreshToken.Claims.(jwt.MapClaims)
	rtClaims["sub"] = name
	rtClaims["id"] = id
	rtClaims["exp"] = time.Now().Add(time.Hour * 24 * 7).Unix()
	rt, err := refreshToken.SignedString(secretKey)

	if err != nil {
		return "", err
	}

	return rt, nil
}

func CreateToken(name string, email string, phone string, username string, id uint) (string, error) {

	godotenv.Load()

	var secretKey = []byte(os.Getenv("SECRET_KEY"))

	claims := jwt.NewWithClaims(jwt.SigningMethodHS256, jwt.MapClaims{
		"sub":      name,
		"email":    email,
		"username": username,
		"phone":    phone,
		"iss":      "token-auth",
		"exp":      time.Now().Add(time.Minute * 30).Unix(),
		"iat":      time.Now().Unix(),
		"id":       id,
	})

	tokenString, err := claims.SignedString(secretKey)
	if err != nil {
		return "", err
	}

	fmt.Println("Token: ", tokenString)

	return tokenString, nil
}
