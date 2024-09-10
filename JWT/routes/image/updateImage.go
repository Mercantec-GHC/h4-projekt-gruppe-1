package routes

import (
	"net/http"
	"strconv"
	"token-auth/db"
	"token-auth/models"

	"github.com/gin-gonic/gin"
)

// update image.
//
// @Summary      Update image
// @Description  Update image for a user
// @Tags         image
// @Param        id path int true "User ID"
// @Param        request body models.Image true "Image data"
// @Accept       json
// @Produce      application/json
// @Success      200 {string} string
// @Router       /image/{id} [patch]
func UpdateImage(c *gin.Context) {
	var updatedImage models.Image
	userID := c.Param("id")

	if err := c.ShouldBindJSON(&updatedImage); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request"})
		return
	}

	userIDUint, err := strconv.ParseUint(userID, 10, 64)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid user ID"})
		return
	}
	updatedImage.UserID = uint(userIDUint)

	if err := db.DB.Db.Model(&models.Image{}).Where("user_id = ?", userID).Updates(updatedImage).Error; err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update image"})
		return
	}
}
