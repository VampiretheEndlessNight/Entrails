package db

import (
	"database/sql"
	"fmt"

	_ "github.com/go-sql-driver/mysql"
	"log"
)

func Connect() {
	var name string
	//dsn := fmt.Sprintf(
	//	"%s:%s@/entrails",
	//	os.Getenv("MYSQL_USER"),
	//	os.Getenv("MYSQL_PASSWORD"))
	//
	//
	//fmt.Println(dsn)

	db, err := sql.Open("mysql", "root:secret@tcp(db:3306)/entrails")
	if err != nil {
		panic(err)
	}
	defer db.Close()

	rows, err := db.Query("show tables")
	if err != nil {
		panic(err)
	}

	defer rows.Close()
	for rows.Next() {
		err := rows.Scan(&name)
		if err != nil {
			log.Fatal(err)
		}
		fmt.Println(name)
	}
	err = rows.Err()
	if err != nil {
		log.Fatal(err)
	}

}

