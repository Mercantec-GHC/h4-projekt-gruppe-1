package models

import "gorm.io/gorm"

type User struct {
	gorm.Model
	Name         string `json:"name" validate:"required"`
	NickName     string `json:"nick_name" validate:"required"`
	Email        string ` json:"email" validate:"required"`
	Password     string `json:"password" validate:"required"`
	Phone        string `json:"phone" validate:"required"`
	ProfilePhoto string `json:"profile_photo"`
	StatsId      string
}
