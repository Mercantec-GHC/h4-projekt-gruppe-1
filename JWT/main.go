package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"strconv"
	"time"
	"token-auth/db"
	"token-auth/models"

	"github.com/gin-gonic/gin"
	"github.com/golang-jwt/jwt/v5"
	"github.com/google/uuid"
	"github.com/joho/godotenv"
	"golang.org/x/crypto/bcrypt"
)

var secretKey = []byte("your-secret-key")

func createToken(username string) (string, error) {
	claims := jwt.NewWithClaims(jwt.SigningMethodHS256, jwt.MapClaims{
		"sub": username,
		"iss": "token-auth",
		"exp": time.Now().Add(time.Hour * 24).Unix(),
		"iat": time.Now().Unix(),
	})

	tokenString, err := claims.SignedString(secretKey)
	if err != nil {
		return "", err
	}

	fmt.Printf("Token claims added: %+v\n", claims)
	return tokenString, nil
}

func getUsers(c *gin.Context) {
	resp, err := http.Get("https://h4-projekt-gruppe-1-1.onrender.com/user")
	if err != nil || resp.StatusCode != http.StatusOK {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to fetch user data"})
		return
	}
	defer resp.Body.Close()

	var users []models.User

	if err := json.NewDecoder(resp.Body).Decode(&users); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to decode user data"})
		return
	}

	c.JSON(http.StatusOK, gin.H{"users": users})
}

func login(c *gin.Context) {
	var loginData struct {
		Username string `json:"username"`
		Password string `json:"password"`
	}

	if err := c.ShouldBindJSON(&loginData); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request"})
		return
	}

	fmt.Printf("Login data received: %+v\n", loginData)

	resp, err := http.Get("https://h4-projekt-gruppe-1-1.onrender.com/user")
	if err != nil || resp.StatusCode != http.StatusOK {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to fetch user data"})
		return
	}
	defer resp.Body.Close()

	var users []models.User
	if err := json.NewDecoder(resp.Body).Decode(&users); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to decode user data"})
		return
	}

	var user *models.User
	for _, u := range users {
		if u.Name == loginData.Username && ComparePassword(u.Password, loginData.Password) {
			user = &u
			break
		}
	}

	if user == nil {
		c.JSON(http.StatusUnauthorized, gin.H{"error": "Invalid username or password"})
		return
	}

	token, err := createToken(user.Name)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to create token"})
		return
	}

	c.JSON(http.StatusOK, gin.H{"token": token})
}

func HashPassword(password string) (string, error) {
	bytes, err := bcrypt.GenerateFromPassword([]byte(password), 14)
	return string(bytes), err
}

func ComparePassword(hash, password string) bool {
	err := bcrypt.CompareHashAndPassword([]byte(hash), []byte(password))
	return err == nil
}

func main() {
	godotenv.Load()
	r := gin.Default()
	r.LoadHTMLGlob("templates/*")

	r.GET("/", func(c *gin.Context) {
		c.HTML(http.StatusOK, "index.html", gin.H{
			"title": "Home Page",
		})
	})
	r.GET("/users", getUsers)
	r.POST("/login", login)

	db.Connect()

	sum := 1
	for i := 0; i < 10; i++ {
		statsId := uuid.New()
		insertSum := strconv.Itoa(sum)

		dummyUsers := []models.User{{
			Name:         "John Doe" + insertSum,
			NickName:     "Johnny" + insertSum,
			Email:        "email@" + insertSum,
			Password:     "password" + insertSum,
			Phone:        "123-456-7890" + insertSum,
			ProfilePhoto: "http://example.com/photo.jpg" + insertSum,
			StatsId:      statsId.String(),
		},
		}

		password := dummyUsers[0].Password
		hash, err := HashPassword(password)
		if err != nil {
			fmt.Printf("Error hashing password: %v\n", err)
		}
		fmt.Printf("Password: %s, Hash: %s\n", password, hash)

		dummyUsers[0].Password = hash

		sum++

		result := db.DB.Db.Create(&dummyUsers)
		if result.Error != nil {
			fmt.Printf("Error inserting dummy user: %v\n", result.Error)
		}

	}

	r.Run(":8080")
}
