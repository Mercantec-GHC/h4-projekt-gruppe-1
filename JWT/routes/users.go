package routes

import (
	"net/http"
	"token-auth/db"
	"token-auth/models"
	"token-auth/util"

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

// GetSingleUser handles the request to get a single user by ID.
//
// @Summary      Find user by ID
// @Description  Return a single user
// @Tags         user
// @Param  		 id path string true "User ID"
// @Accept       json
// @Produce 	 application/json
// @Success      200  {object}   models.User
// @Router       /user/{id} [get]
func GetSingleUser(c *gin.Context) {
	id := c.Param("id")
	var user models.User

	if err := db.DB.Db.Where("id = ?", id).First(&user).Error; err != nil {
		c.JSON(http.StatusNotFound, gin.H{"message": "User not found"})
		return
	}

	c.IndentedJSON(http.StatusOK, user)
}

// DeleteUser handles the request to delete a user by ID.
//
// @Summary      Delete user with specific id
// @Description  Delete user
// @Tags         user
// @Param  		 id path string true "User ID"
// @Accept       json
// @Produce 	 application/json
// @Success      200
// @Router       /user/{id} [delete]
func DeleteUser(c *gin.Context) {
	id := c.Param("id")
	var user models.User

	if err := db.DB.Db.Where("id = ?", id).First(&user).Error; err != nil {
		c.JSON(http.StatusNotFound, gin.H{"message": "User not found"})
		return
	}

	db.DB.Db.Delete(&user)

	c.JSON(http.StatusOK, gin.H{"message": "User deleted"})
}

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
