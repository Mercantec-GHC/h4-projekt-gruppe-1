package routes

import (
	"net/http"
	"token-auth/db"
	"token-auth/models"

	"github.com/gin-gonic/gin"
)

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

	c.IndentedJSON(http.StatusOK, user.Username)
}
