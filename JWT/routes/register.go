package routes

import (
	"net/http"
	"token-auth/db"
	"token-auth/models"

	"github.com/gin-gonic/gin"
)

func Register(c *gin.Context) {

	var newUser *models.User

	if err := c.ShouldBindJSON(&newUser); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request"})
		return
	}

	/*  Opretter ny bruger i db */
	if err := db.DB.Db.Create(&newUser).Error; err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to register user"})
		return
	}

	c.JSON(http.StatusCreated, gin.H{"message": "User registered"})
}
