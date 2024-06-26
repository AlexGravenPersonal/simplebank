package main

import (
	"database/sql"
	"log"

	"github.com/AlexGravenPersonal/simple_bank/api"
	db "github.com/AlexGravenPersonal/simple_bank/db/sqlc"
	_ "github.com/lib/pq"
)

const (
	dbDriver      = "postgres"
	dbSource      = "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable"
	serverAddress = "0.0.0.0:8080"
)

func main() {
	conn, err := sql.Open(dbDriver, dbSource)
	if err != nil {
		log.Fatal("CANNOT CONNECT TO DB", err)
	}

	store := db.NewStore(conn)
	server := api.NewServer(store)

	err = server.Start(serverAddress)
	if err != nil {
		log.Fatal("CANNOT START SERVER", err)
	}
}
