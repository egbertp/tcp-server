package main

import (
	"fmt"
	"net"
	"os"
	"flag"
	"log"
	"time"
	"github.com/egbertp/tcp-server/helpers"
	"bufio"
)

/* A Simple function to verify error */
func CheckError(err error) {
	if err != nil {
		fmt.Println("Error: ", err)
		os.Exit(0)
	}
}


// Variables to identiy the build
var (
	CommitHash string
	VersionTag string
	BuildTime  string
)


func main() {
	var (
		httpAddr = flag.String("http", "0.0.0.0:7000", "HTTP server address")
	)
	flag.Parse()

	log.Printf("The version is: %s; the commit hash is: %s. Build time is: %s", VersionTag, CommitHash, helpers.ParseBuildTime(BuildTime).Format(time.RFC1123))
	log.Printf("Starting TCP server on address: %s", *httpAddr)


	li, err := net.Listen("tcp", *httpAddr)
	if err != nil {
		log.Fatalln(err)
	}
	defer li.Close()

	for {
		conn, err := li.Accept()
		if err != nil {
			log.Println(err)
			continue
		}
		go handle(conn)
	}
}

func handle(conn net.Conn) {
	scanner := bufio.NewScanner(conn)
	for scanner.Scan() {
		ln := scanner.Text()
		fmt.Fprintf(conn, "%s \n", ln)
		log.Printf("%s \n", ln)
	}
}