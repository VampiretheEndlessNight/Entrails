package db

import (
	"database/sql"
	"fmt"

	_ "github.com/go-sql-driver/mysql"
)

func connect() {

	db, err := sql.Open("mysql", "root:root@tcp(172.17.0.2:3306)/test-db")
	if err != nil {
		panic(err)
	}
	defer db.Close()

	rows, err := db.Query("SELECT table_name FROM user_tables")
	if err != nil {
		panic(err)
	}

	defer rows.Close()

}

