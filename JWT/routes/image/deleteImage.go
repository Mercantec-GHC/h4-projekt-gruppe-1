package routes

import (
	"net/http"
	"token-auth/db"
	"token-auth/models"

	"github.com/gin-gonic/gin"
)

// delete image.
//
// @Summary      Delete image
// @Description  Delete image for a user
// @Tags         image
// @Param        id path int true "User ID"
// @Produce      application/json
// @Success      200 {string} string
// @Router       /image/{id} [delete]
func DeleteImage(c *gin.Context) {
	userID := c.Param("id")

	if err := db.DB.Db.Where("user_id = ?", userID).Delete(&models.Image{}).Error; err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to delete image"})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Image deleted"})
}
