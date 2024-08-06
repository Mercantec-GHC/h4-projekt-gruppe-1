package models

import (
	"database/sql"
)

type User struct {
	ID       int
	Username string
	Email    string
	Password string
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

func InsertUser(db *sql.DB, user User) error {
	query := "INSERT INTO users (username, email, password) VALUES ($1, $2, $3)"
	_, err := db.Exec(query, user.Username, user.Email, user.Password)
	if err != nil {
		return err
	}
	return nil
}
