package main


import (
"fmt"
"net/http"
	"github.com/gorilla/mux"
	"io/ioutil"
	"encoding/json"
)

func main() {
fmt.Println("Server starting; listening on port 3000")
http.ListenAndServe(":3000", Handlers())
}

func Handlers() *mux.Router {
	r := mux.NewRouter()

	r.HandleFunc("/", basicHandler).Methods("POST") //there is just one endpoint!

	return r
}

func basicHandler(w http.ResponseWriter, r *http.Request) {
	body, err := ioutil.ReadAll(r.Body)
	if err != nil {
		fmt.Printf("Error: %s\n", err)
		w.WriteHeader(http.StatusInternalServerError)
		return
	}

	msg := (fmt.Sprintf("hello, you sent: %s", body))

	msgjson, err := json.Marshal(msg)
	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		fmt.Printf("Error: %s\n", err)
		return
	}

	w.Write(msgjson)
}