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
