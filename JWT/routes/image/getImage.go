package routes

import (
	"net/http"
	"token-auth/db"
	"token-auth/models"

	"github.com/gin-gonic/gin"
)

// get image.
//
// @Summary      Get image
// @Description  Get image for a user
// @Tags         image
// @Param        id path int true "User ID"
// @Produce      application/json
// @Success      200 {object} models.Image
// @Router       /image/{id} [get]
func GetImage(c *gin.Context) {
	var image models.Image
	userID := c.Param("id")

	// Find the image by user ID
	if err := db.DB.Db.Where("user_id = ?", userID).Last(&image).Error; err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Image not found"})
		return
	}

	c.JSON(http.StatusOK, image)
}
