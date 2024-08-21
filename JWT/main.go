package main

import (
	"net/http"
	"token-auth/db"
	"token-auth/routes"

	_ "token-auth/docs"

	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
	"github.com/joho/godotenv"
	swaggerFiles "github.com/swaggo/files"
	ginSwagger "github.com/swaggo/gin-swagger"
)

func main() {
	godotenv.Load()
	r := gin.Default()
	r.LoadHTMLGlob("templates/*")

	r.Use(cors.New(cors.Config{
		AllowAllOrigins: true,
		AllowMethods:    []string{"GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS"},
		AllowHeaders:    []string{"Origin", "Content-Type", "Accept", "Authorization"},
		ExposeHeaders:   []string{"Content-Length"},
	}))

	r.GET("/", func(c *gin.Context) {
		c.HTML(http.StatusOK, "index.html", gin.H{
			"title": "Home Page",
		})
	})
	db.Connect()

	r.GET("/users", routes.Users)
	r.GET("/user/:id", routes.GetSingleUser)
	r.DELETE("/user/:id", routes.DeleteUser)
	r.PATCH("/user/:id", routes.UpdateUser)
	r.POST("/register", routes.Register)
	r.POST("/login", routes.Login)

	r.GET("/swagger/*any", ginSwagger.WrapHandler(swaggerFiles.Handler))
	r.Run(":8080")
}
