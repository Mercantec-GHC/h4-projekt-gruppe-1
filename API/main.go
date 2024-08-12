package main

import (
	"database/sql"
	"fmt"
	"log"
	"net/http"
	"os"

	model "userAPI/model"

	"github.com/gin-gonic/gin"
	_ "github.com/lib/pq"
)

var users = model.GenerateDummyUsers()

func getUsers(c *gin.Context) {
	c.IndentedJSON(http.StatusOK, users)
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

func InsertUser(db *sql.DB, user *model.User) error {
	query := "INSERT INTO users (username, email, password) VALUES ($1, $2, $3)"
	_, err := db.Exec(query, user.Name, user.Email, user.Password)
	if err != nil {
		return err
	}
	return nil
}

func main() {
	token := os.Getenv("connection")
	router := gin.Default()
	router.GET("/users", getUsers)

	router.Run("localhost:8080")

	db, err := sql.Open("postgres", token)
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	err = CreateUserTable(db)
	if err != nil {
		log.Fatal(err)
	}

	dummyUsers := model.GenerateDummyUsers()
	for _, user := range dummyUsers {
		err = InsertUser(db, user)
		if err != nil {
			log.Fatal(err)
		}
		fmt.Printf("Inserted user: %s\n", user.Name)
	}
}
