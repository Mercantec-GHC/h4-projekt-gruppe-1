package routes

import (
	"github.com/gin-gonic/gin"
)

func LoginRoutes(r *gin.Engine) {
	r.POST("/login", Login)
}
