package main

import (
	"bytes"
	"net/http"
	"time"
)

var smallBody = bytes.Repeat([]byte("Hello World\n"), 10*10)
var largeBody = bytes.Repeat([]byte("Hello World\n"), 100*100)

func small(w http.ResponseWriter, r *http.Request) {
	w.Write(smallBody)
}

func large(w http.ResponseWriter, r *http.Request) {
	w.Write(largeBody)
}

func blocking(w http.ResponseWriter, r *http.Request) {
	time.Sleep(10 * time.Millisecond)
	w.Write(smallBody)
}

func hello(w http.ResponseWriter, r *http.Request) {
	w.Write([]byte("Hello World!"))
}

func main() {
	http.HandleFunc("/small", small)
	http.HandleFunc("/large", large)
	// Go's scheduler suspends only the goroutine during time.Sleep, so both
	// endpoints are non-blocking at the server level; they are exposed
	// separately to mirror the Ruby application's routes.
	http.HandleFunc("/blocking", blocking)
	http.HandleFunc("/nonblocking", blocking)
	http.HandleFunc("/", hello)

	http.ListenAndServe(":80", nil)
}
