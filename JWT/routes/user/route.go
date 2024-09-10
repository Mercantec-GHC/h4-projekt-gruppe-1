package routes

import (
	"github.com/gin-gonic/gin"
)

func UserRoutes(r *gin.Engine) {
	r.GET("/users", Users)
	r.GET("/user/:id", GetSingleUser)
	r.DELETE("/user/:id", DeleteUser)
	r.PATCH("/user/:id", UpdateUser)
}
