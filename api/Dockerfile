# Start from a Debian image with the latest version of Go installed
# and a workspace (GOPATH) configured at /go.
FROM golang

ADD . /go/src/github.com/VampiretheEndlessNight/entrails/api

RUN go get github.com/gorilla/mux & go get github.com/go-sql-driver/mysql

RUN go install github.com/VampiretheEndlessNight/entrails/api


ENTRYPOINT /go/bin/api

# Document that the service listens on port 8080.
EXPOSE 8080
