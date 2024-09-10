package routes

import (
	"net/http"
	"strconv"
	"token-auth/db"
	"token-auth/models"

	"github.com/gin-gonic/gin"
)

// upload image.
//
// @Summary      Upload image
// @Description  Upload image for a user
// @Tags         image
// @Param        id path int true "User ID"
// @Param        request body models.Image true "Image data"
// @Accept       json
// @Produce      application/json
// @Success      200 {string} string
// @Router       /image/{id} [post]
func UploadImage(c *gin.Context) {
	var newImage models.Image
	userID := c.Param("id")

	if err := c.ShouldBindJSON(&newImage); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request"})
		return
	}

	userIDUint, err := strconv.ParseUint(userID, 10, 64)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid user ID"})
		return
	}
	newImage.UserID = uint(userIDUint)

	if err := db.DB.Db.Create(&newImage).Error; err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to upload image"})
		return
	}

	c.JSON(http.StatusCreated, gin.H{"message": "Image uploaded"})
}
