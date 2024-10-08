package routes

import (
	"fmt"
	"net/http"
	"token-auth/db"
	"token-auth/models"
	"token-auth/util"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

// Login user.
//
// @Summary      Update user with specific id
// @Description  Update user
// @Tags         user
// @Param        request body models.LoginData true "Login data"
// @Accept       json
// @Produce      application/json
// @Success      200 {object} map[string]string "token and refresh token"
// @Router       /login [post]
func Login(c *gin.Context) {
	var loginData models.LoginData

	if err := c.ShouldBindJSON(&loginData); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request"})
		return
	}

	var user models.User
	if err := db.DB.Db.Where("email = ?", loginData.Email).First(&user).Error; err != nil {
		if err == gorm.ErrRecordNotFound {
			c.JSON(http.StatusUnauthorized, gin.H{"error": "Invalid email or password"})
		} else {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to fetch user data"})
		}
		return
	}

	if !util.ComparePassword(user.Password, loginData.Password) {
		c.JSON(http.StatusUnauthorized, gin.H{"error": "Invalid email or password"})
		return
	}

	fmt.Println(loginData)

	refreshToken, err := util.CreateRefreshToken(user.Name, user.ID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to create refresh token"})
		return
	}

	user.RefreshToken = refreshToken
	if err := db.DB.Db.Save(&user).Error; err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update user data"})
		return
	}

	token, err := util.CreateToken(user.Name, user.Email, user.Phone, user.Username, user.ID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to create token"})
		return
	}

	c.JSON(http.StatusOK, gin.H{"token": token, "refreshToken": refreshToken})
	fmt.Println("Refresh Token: " + refreshToken)
}
