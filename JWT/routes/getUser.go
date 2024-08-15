package routes

import (
	"fmt"
	"net/http"
	"token-auth/models"

	"github.com/gin-gonic/gin"
)

func GetSingleUser(c *gin.Context) {
	id := c.Param("id")
	var users []models.User
	fmt.Println("ID: ", id)
	fmt.Println("Users: ", users)

	for _, item := range users {
		if item.ID == id {
			c.IndentedJSON(http.StatusOK, item)
			return
		}
	}
	c.IndentedJSON(http.StatusNotFound, gin.H{"message": "User not found"})
}
