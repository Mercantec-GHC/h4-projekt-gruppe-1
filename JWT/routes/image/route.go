package routes

import (
	"github.com/gin-gonic/gin"
)

func ImageRoutes(r *gin.Engine) {
	r.POST("/image/:id", UploadImage)
	r.PATCH("/image/:id", UpdateImage)
	r.GET("/image/:id", GetImage)
	r.DELETE("/image/:id", DeleteImage)
}
