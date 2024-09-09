package routes

/*func RefreshToken(c *gin.Context) {
	godotenv.Load()
	var secretKey = []byte(os.Getenv("SECRET_KEY"))

	var refreshTokenData struct {
		RefreshToken string `json:"refresh_token"`
	}

	if err := c.ShouldBindJSON(&refreshTokenData); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request"})
		return
	}

	// Parse and validate refresh token
	token, err := jwt.Parse(refreshTokenData.RefreshToken, func(token *jwt.Token) (interface{}, error) {
		return secretKey, nil
	})
	if err != nil || !token.Valid {
		c.JSON(http.StatusUnauthorized, gin.H{"error": "Invalid refresh token"})
		return
	}

	// Extract user ID from the token
	claims, ok := token.Claims.(jwt.MapClaims)
	if !ok || !token.Valid {
		c.JSON(http.StatusUnauthorized, gin.H{"error": "Invalid token"})
		return
	}

	userID := claims["id"].(uint)

	// Fetch the user from the database (optional)
	var user models.User
	if err := db.DB.Db.First(&user, userID).Error; err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "User not found"})
		return
	}

	// Generate new access token
	newToken, _, err := util.CreateToken(user.Name, user.Email, user.Phone, user.Username, user.ID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to create token"})
		return
	}

	c.JSON(http.StatusOK, gin.H{"token": newToken, "ersgsdreergsw": "weqrfasdas"})
}*/
