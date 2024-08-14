package main

import (
	"net/http"
	"token-auth/db"
	"token-auth/routes"

	"github.com/gin-gonic/gin"
	"github.com/joho/godotenv"
)

func main() {
	godotenv.Load()
	r := gin.Default()
	r.LoadHTMLGlob("templates/*")

	r.GET("/", func(c *gin.Context) {
		c.HTML(http.StatusOK, "index.html", gin.H{
			"title": "Home Page",
		})
	})
	r.GET("/users", routes.Users)
	r.POST("/login", routes.Login)

	db.Connect()

	r.Run(":8080")
}
