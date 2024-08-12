package models

type User struct {
	ID         int    `json:"id"`
	Name       string `json:"name"`
	Nickname   string `json:"nickname"`
	Phone      string `json:"phone"`
	Email      string `json:"email"`
	Password   string `json:"password"`
	ProfilePic string `json:"profilePic"`
	StatsID    int    `json:"statsID"`
}

func NewUser(name, email, phone, nickname, profilePic, password string, statsID int) *User {
	return &User{
		Name:       name,
		Nickname:   nickname,
		Phone:      phone,
		ProfilePic: profilePic,
		Email:      email,
		Password:   password,
		StatsID:    statsID,
	}
}

func GenerateDummyUsers() []*User {
	users := []*User{
		NewUser("user1", "user1@example.com", "password1", "", "", "", 0),
		NewUser("user2", "user2@example.com", "password2", "", "", "", 0),
		NewUser("user3", "user3@example.com", "password3", "", "", "", 0),
		NewUser("user4", "user4@example.com", "password4", "", "", "", 0),
		NewUser("kim", "user5@example.com", "password5", "", "", "", 0),
	}
	return users
}
