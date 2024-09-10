package routes

import (
	"net/http"
	"token-auth/db"
	"token-auth/models"
	"token-auth/util"

	"github.com/gin-gonic/gin"
)

// @Summary Update user password by email
// @Description Update user password by email
// @Tags users
// @Accept  json
// @Produce  json
// @Param   email path string true "User Email"
// @Param   password body string true "New Password"
// @Success 200 {string} string
// @Failure 404 {object} models.ErrorResponse
// @Failure 500 {object} models.ErrorResponse
// @Router /user/email/{email}/password [post]
func postNewPasswordByMail(c *gin.Context) {
	email := c.Param("email")
	var user models.User

	// Retrieve the user by email
	if err := db.DB.Db.Where("email = ?", email).First(&user).Error; err != nil {
		c.JSON(http.StatusNotFound, gin.H{"Message": "User not found"})
		return
	}

	// Bind the new password from the request body
	var requestBody struct {
		Password string `json:"password"`
	}
	if err := c.ShouldBindJSON(&requestBody); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"Message": "Invalid request"})
		return
	}

	// Hash the new password
	hashedPassword, err := util.HashPassword(requestBody.Password)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"Message": "Failed to hash password"})
		return
	}

	// Update the user's password in the database
	user.Password = hashedPassword
	if err := db.DB.Db.Save(&user).Error; err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"Message": "Failed to update password"})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Password updated successfully"})
}
