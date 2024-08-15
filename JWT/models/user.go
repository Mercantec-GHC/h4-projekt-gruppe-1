package models

import "time"

type User struct {
	ID           string     `json:"id" gorm:"primaryKey"`
	CreatedAt    time.Time  `json:"created_at"`
	UpdatedAt    time.Time  `json:"updated_at"`
	DeletedAt    *time.Time `json:"deleted_at,omitempty" gorm:"index"`
	Name         string     `json:"name" validate:"required"`
	NickName     string     `json:"nick_name" validate:"required"`
	Email        string     `json:"email" validate:"required"`
	Password     string     `json:"password" validate:"required"`
	Phone        string     `json:"phone" validate:"required"`
	ProfilePhoto string     `json:"profile_photo"`
	StatsId      string     `json:"stats_id"`
}
