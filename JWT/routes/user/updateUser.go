package routes

import (
	"net/http"
	"token-auth/db"
	"token-auth/models"
	"token-auth/util"

	"github.com/gin-gonic/gin"
)

// UpdateUser handles the request to update a user by ID.
//
// @Summary      Update user with specific id
// @Description  Update user
// @Tags         user
// @Param        id path string true "User ID"
// @Param        request body models.User true "User data"
// @Accept       json
// @Produce      application/json
// @Success      200 {object} map[string]interface{} "User updated"
// @Router       /user/{id} [patch]
func UpdateUser(c *gin.Context) {
	id := c.Param("id")
	var user models.User

	if err := db.DB.Db.Where("id = ?", id).First(&user).Error; err != nil {
		c.JSON(http.StatusNotFound, gin.H{"message": "User not found"})
		return
	}

	var updatedUser models.User
	if err := c.ShouldBindJSON(&updatedUser); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request", "details": err.Error()})
		return
	}

	// If the password has been changed, hash the new password
	if updatedUser.Password != user.Password {
		hashedPassword, err := util.HashPassword(updatedUser.Password)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to hash password", "details": err.Error()})
			return
		}
		updatedUser.Password = hashedPassword
	}

	if err := db.DB.Db.Model(&user).Updates(updatedUser).Error; err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update user", "details": err.Error()})
		return
	}

	if err := db.DB.Db.Where("id = ?", id).First(&user).Error; err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve updated user", "details": err.Error()})
		return
	}

	// Generate a new token for the updated user
	token, err := util.CreateToken(user.Name, user.Email, user.Phone, user.Username, user.ID, user.RefreshToken)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to generate token", "details": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "User updated", "token": token})
}
