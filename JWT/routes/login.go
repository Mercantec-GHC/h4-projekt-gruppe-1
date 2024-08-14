package routes

import (
	"encoding/json"
	"fmt"
	"net/http"
	"token-auth/models"
	"token-auth/util"

	"github.com/gin-gonic/gin"
)

func Login(c *gin.Context) {

	var user *models.User
	var loginData *models.LoginData

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

	for _, u := range users {
		if u.Name == loginData.Username && util.ComparePassword(u.Password, loginData.Password) {
			user = &u
			break
		}
	}

	if user == nil {
		c.JSON(http.StatusUnauthorized, gin.H{"error": "Invalid username or password"})
		return
	}

	token, err := util.CreateToken(user.Name)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to create token"})
		return
	}

	c.JSON(http.StatusOK, gin.H{"token": token})
}
