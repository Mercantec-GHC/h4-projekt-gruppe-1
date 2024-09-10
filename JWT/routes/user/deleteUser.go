package routes

import (
	"net/http"
	"token-auth/db"
	"token-auth/models"

	"github.com/gin-gonic/gin"
)

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
