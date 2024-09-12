package routes

import (
	"github.com/gin-gonic/gin"
)

func UserRoutes(r *gin.Engine) {
	r.GET("/users", Users)
	r.GET("/user/:id", GetSingleUser)
	r.DELETE("/user/:id", DeleteUser)
	r.GET("/user/email/:email", getUserByMail)
	r.PATCH("/user/:id", UpdateUser)
	r.POST("/user/password/:email", postNewPasswordByMail)
}
