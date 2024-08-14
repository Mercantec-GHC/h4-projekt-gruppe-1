package routes

import (
	"net/http"
	"token-auth/models"

	"github.com/gin-gonic/gin"
)

func Users(c *gin.Context) {
	var users []models.User
	var newUser models.User

	if err := c.ShouldBindJSON(&newUser); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request"})
		return
	}

	users = append(users, newUser)
	c.IndentedJSON(http.StatusOK, newUser)
}
