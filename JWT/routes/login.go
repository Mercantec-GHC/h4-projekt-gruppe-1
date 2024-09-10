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
// @Success      200 {string} string
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

	// Compare the password with the hashed password function is in util folder hash.go
	if !util.ComparePassword(user.Password, loginData.Password) {
		c.JSON(http.StatusUnauthorized, gin.H{"error": "Invalid email or password"})
		return
	}

	fmt.Println(loginData)

	//If the user has a refresh token then create a acess token otherwise make both if login credentials are correct
	if user.RefreshToken {
		token, err := util.CreateToken(user.Name, user.Email, user.Phone, user.Username, user.ID, user.RefreshToken)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to create token"})
			return
		}
		c.JSON(http.StatusOK, gin.H{"token": token})

	} else {
		refreshToken, err := util.CreateRefreshToken(user.Name, user.ID)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to create refresh token"})
			return
		}

		user.RefreshToken = true

		if err := db.DB.Db.Save(&user).Error; err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update user data"})
			return
		}

		token, err := util.CreateToken(user.Name, user.Email, user.Phone, user.Username, user.ID, user.RefreshToken)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to create token"})
			return
		}

		c.JSON(http.StatusOK, gin.H{"token": token, "refreshToken": refreshToken})
	}
}
