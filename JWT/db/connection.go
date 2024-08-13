package db

import (
	"fmt"
	"log"
	"os"
	"token-auth/models"

	"github.com/joho/godotenv"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
	"gorm.io/gorm/logger"
)

type DbInstance struct {
	Db *gorm.DB
}

var DB DbInstance

func Connect() {

	godotenv.Load()

	dbPassword := os.Getenv("DB_PASSWORD")
	log.Printf("DB_PASSWORD : %s", dbPassword)

	dsn := fmt.Sprintf("postgresql://SwishBeatboxDB_owner:%s@ep-summer-hill-a2rvpx5f.eu-central-1.aws.neon.tech/SwishBeatboxDB?sslmode=require", dbPassword)

	db, err := gorm.Open(postgres.Open(dsn), &gorm.Config{
		Logger: logger.Default.LogMode(logger.Info),
	})

	if err != nil {
		panic("Could not connect")
	}
	log.Println("Connected to database")

	db.Logger.LogMode(logger.Info)

	db.AutoMigrate(&models.User{})

	DB = DbInstance{Db: db}
}
