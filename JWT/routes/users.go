package routes

import (
	"net/http"
	"token-auth/db"
	"token-auth/models"

	"github.com/gin-gonic/gin"
)

func Users(c *gin.Context) {
	var users []models.User

	if result := db.DB.Db.Find(&users); result.Error != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": result.Error.Error()})
		return
	}

	c.JSON(http.StatusOK, users)
}
