package routes

import (
	"net/http"
	"token-auth/db"
	"token-auth/models"

	"github.com/gin-gonic/gin"
)

// @Summary Get user by email
// @Description Get user details by email
// @Tags users
// @Accept  json
// @Produce  json
// @Param  		 email path string true "User ID"
// @Success 200 {object} models.User
// @Router /user/email/{email} [get]
func getUserByMail(c *gin.Context) {
	mail := c.Param("email")
	var user models.User

	if err := db.DB.Db.Where("email = ?", mail).First(&user).Error; err != nil {
		c.JSON(http.StatusNotFound, gin.H{"message": "User not found"})
		return
	}

	c.IndentedJSON(http.StatusOK, user)
}
