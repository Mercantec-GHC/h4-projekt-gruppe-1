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
		log.Println("Error binding JSON:", err)
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request"})
		return
	}

	/*  Opretter ny bruger i db */
	if err := db.DB.Db.Create(&newUser).Error; err != nil {
		log.Println("Validation failed: User name is empty")
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to register user"})
		return
	}

	// Attempt to create the new user in the database
	if err := db.DB.Db.Create(&newUser).Error; err != nil {
		log.Println("Error creating user in the database:", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to register user: " + err.Error()})
		return
	}

	log.Println("User registered successfully:", newUser.Name)
	c.JSON(http.StatusCreated, gin.H{"message": "User registered"})
}
