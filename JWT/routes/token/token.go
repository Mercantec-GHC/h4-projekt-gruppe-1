package routes

import (
	"fmt"
	"net/http"
	"os"
	"token-auth/db"
	"token-auth/models"
	"token-auth/util"

	"github.com/gin-gonic/gin"
	"github.com/golang-jwt/jwt"
	"github.com/joho/godotenv"
)

// @Summary Refresh token
// @Description Refresh the access token using a valid refresh token
// @Tags token
// @Accept  application/x-www-form-urlencoded
// @Produce  json
// @Param   refresh_token formData string true "Refresh Token"
// @Success 200 {object} map[string]string "access_token"
// @Router /token/refresh [post]
func RefreshToken(c *gin.Context) {
	refreshToken := c.PostForm("refresh_token")

	if refreshToken == "" {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request"})
		return
	}

	godotenv.Load()
	secretKey := []byte(os.Getenv("SECRET_KEY"))

	token, err := jwt.Parse(refreshToken, func(token *jwt.Token) (interface{}, error) {
		if _, ok := token.Method.(*jwt.SigningMethodHMAC); !ok {
			return nil, fmt.Errorf("unexpected signing method: %v", token.Header["alg"])
		}
		return secretKey, nil
	})

	if err != nil || !token.Valid {
		c.JSON(http.StatusUnauthorized, gin.H{"error": "Invalid refresh token"})
		return
	}

	claims, ok := token.Claims.(jwt.MapClaims)
	if !ok || !token.Valid {
		c.JSON(http.StatusUnauthorized, gin.H{"error": "Invalid token claims"})
		return
	}

	userID := uint(claims["id"].(float64))
	var user models.User

	if err := db.DB.Db.Where("id = ?", userID).First(&user).Error; err != nil {
		c.JSON(http.StatusNotFound, gin.H{"message": "User not found"})
		return
	}

	newToken, err := util.CreateToken(user.Name, user.Email, user.Phone, user.Username, user.ID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to create access token"})
		return
	}

	c.JSON(http.StatusOK, gin.H{"access_token": newToken})
}
