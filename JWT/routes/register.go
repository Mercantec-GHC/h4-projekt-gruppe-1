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

	users := db.DB.Db.Create(&newUser)
	c.IndentedJSON(http.StatusOK, users)

}
