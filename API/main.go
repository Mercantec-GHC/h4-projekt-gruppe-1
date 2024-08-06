package main

import (
	"database/sql"
	"fmt"
	"log"

	_ "github.com/lib/pq"
)

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

func generateDummyUsers() []*User {
	users := []*User{
		NewUser("user1", "user1@example.com", "password1", "", "", "", 0),
		NewUser("user2", "user2@example.com", "password2", "", "", "", 0),
		NewUser("user3", "user3@example.com", "password3", "", "", "", 0),
		NewUser("user4", "user4@example.com", "password4", "", "", "", 0),
		NewUser("kim", "user5@example.com", "password5", "", "", "", 0),
	}
	return users
}

func CreateUserTable(db *sql.DB) error {
	query := `
    CREATE TABLE IF NOT EXISTS users (
        id SERIAL PRIMARY KEY,
        username VARCHAR(50) NOT NULL,
        email VARCHAR(100) NOT NULL,
        password VARCHAR(100) NOT NULL
    )`
	_, err := db.Exec(query)
	if err != nil {
		return err
	}
	return nil
}

func InsertUser(db *sql.DB, user *User) error {
	query := "INSERT INTO users (username, email, password) VALUES ($1, $2, $3)"
	_, err := db.Exec(query, user.Name, user.Email, user.Password)
	if err != nil {
		return err
	}
	return nil
}

func main() {
	connStr := "postgresql://SwishBeatboxDB_owner:CkIKMYJ5t1Tx@ep-summer-hill-a2rvpx5f.eu-central-1.aws.neon.tech/SwishBeatboxDB?sslmode=require"
	db, err := sql.Open("postgres", connStr)
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	err = CreateUserTable(db)
	if err != nil {
		log.Fatal(err)
	}

	dummyUsers := generateDummyUsers()
	for _, user := range dummyUsers {
		err = InsertUser(db, user)
		if err != nil {
			log.Fatal(err)
		}
		fmt.Printf("Inserted user: %s\n", user.Name)
	}
}
