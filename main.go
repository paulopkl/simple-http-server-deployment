package main

import (
	"encoding/json"
	"fmt"
	"html/template"
	"io/ioutil"
	"net/http"
	"os"
	"path/filepath"
	"strings"

	log "github.com/sirupsen/logrus"
)

// Response defines the structure of the JSON response
type Response struct {
	Message string `json:"message"`
	Status  int    `json:"status"`
}

type Page struct {
	Title string
}

var templ = func() *template.Template {
	// Get the current working directory
	currentDir, err := os.Getwd()
	if err != nil {
		log.Fatalf("Failed to get current directory: %v", err)
	}

	// Append the "html" folder to the current directory
	htmlDir := filepath.Join(currentDir, "html")

	t := template.New("")
	err = filepath.Walk(htmlDir, func(path string, info os.FileInfo, err error) error {
		if strings.Contains(path, ".html") {
			fmt.Println(path)
			_, err = t.ParseFiles(path)
			if err != nil {
				fmt.Println(err)
			}
		}
		return err
	})

	if err != nil {
		panic(err)
	}
	return t
}()

func homepageHandler(w http.ResponseWriter, r *http.Request) {
	fmt.Println("Home")
	templ.ExecuteTemplate(w, "main", &Page{Title: "Welcome to TL;DR"})
}
func aboutHandler(w http.ResponseWriter, r *http.Request) {
	fmt.Println("About")
	templ.ExecuteTemplate(w, "about", &Page{Title: "About TL;DR"})
}

func init() {
	log.WithFields(log.Fields{
		"animal": "walrus",
		"number": 1,
		"size":   10,
	}).Info("A walrus appears")
}

func main() {
	// Specify the directory you want to list
	dirPath := "."

	// Read directory contents
	files, err := ioutil.ReadDir(dirPath)
	if err != nil {
		log.Fatalf("Failed to read directory: %v", err)
	}

	// Print each file and directory
	for _, file := range files {
		if file.IsDir() {
			fmt.Printf("[DIR]  %s\n", file.Name())
		} else {
			fmt.Printf("[FILE] %s\n", file.Name())
		}
	}

	http.HandleFunc("GET /", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintln(w, "Hello World!")
	})

	http.HandleFunc("GET /json", func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "application/json")

		response := Response{
			Message: "Hello, World!",
			Status:  200,
		}

		w.WriteHeader(http.StatusCreated)

		json.NewEncoder(w).Encode(response)
	})

	http.HandleFunc("GET /main", homepageHandler)
	http.HandleFunc("GET /about", aboutHandler)

	port := ""

	if os.Getenv("ENVIRONMENT") == "production" {
		port = ":80"
	} else {
		port = ":8080"
	}

	fmt.Println("this is a inserted line, it worked!")
	fmt.Printf("Server started on port %s", port)
	if err := http.ListenAndServe(port, nil); err != nil {
		panic(err)
	}
}
