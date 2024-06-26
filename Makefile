postgres:
	docker run --name postgres12 -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres

createdb:
	docker exec -it postgres12 createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it postgres12 dropdb simple_bank

dbconsole:
	docker exec -it postgres12 psql postgresql://root:secret@localhost:5432/simple_bank

migrateup:
	migrate -path db/migrations -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migrations -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose down


server:
	go run main.go

sqlc:
	sqlc generate

test:
	go test -v -cover ./...



.PHONY: postgres createdb dropdb dbconsole migrateup migratedown server
