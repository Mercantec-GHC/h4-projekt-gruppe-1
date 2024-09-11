package routes

import (
	"github.com/gin-gonic/gin"
)

func GetNewTokenRoutes(r *gin.Engine) {
	r.POST("/token/refresh", RefreshToken)

}
