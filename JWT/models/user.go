package models

type User struct {
	ID       uint   `json:"id" gorm:"primary_key"`
	Name     string `json:"name"`
	Username string `json:"username"`
	Email    string `json:"email" gorm:"unique"`
	Password string `json:"password"`
	Phone    string `json:"phone"`
	Image    Image  `json:"image" gorm:"foreignkey:UserID"`
}

type Image struct {
	ID     uint   `json:"id" gorm:"primary_key"`
	Name   string `json:"name"`
	Image  []byte `json:"image"`
	UserID uint   `json:"user_id"`
}
