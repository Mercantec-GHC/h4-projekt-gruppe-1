package main

import (
	"database/sql"
	"fmt"
	"log"

	_ "github.com/lib/pq"
)

func main() {
	connStr := "postgresql://SwishBeatboxDB_owner:CkIKMYJ5t1Tx@ep-summer-hill-a2rvpx5f.eu-central-1.aws.neon.tech/SwishBeatboxDB?sslmode=require"
	db, err := sql.Open("postgres", connStr)
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	err = models.CreateUserTable(db)
	if err != nil {
		log.Fatal(err)
	}

	user := models.User{
		Username: "john",
		Email:    "john@example.com",
		Password: "password123",
	}

	err = models.InsertUser(db, user)
	if err != nil {
		log.Fatal(err)
	}

	fmt.Println("User inserted successfully")
}
