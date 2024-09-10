package routes

import (
	"net/http"
	"token-auth/db"
	"token-auth/models"

	"github.com/gin-gonic/gin"
)

// Users handles the request to list all existing user accounts.
//
// @Summary      List user accounts
// @Description  Retrieves a list of user accounts
// @Tags         users
// @Success      200  {array}   models.User
// @Router       /users [get]
func Users(c *gin.Context) {
	var users []models.User

	// Query the database to find all users
	if result := db.DB.Db.Find(&users); result.Error != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": result.Error.Error()})
		return
	}

	c.JSON(http.StatusOK, users)
}
