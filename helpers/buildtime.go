package helpers

import (
	"log"
	"time"
)

func ParseBuildTime(BuildTime string) time.Time {
	// See https://pauladamsmith.com/blog/2011/05/go_time.html
	// See https://golang.org/pkg/time/#pkg-constants

	layout := "2006-01-02T15:04:05-0700"
	t, err := time.Parse(layout, BuildTime)

	if err != nil {
		log.Println(err)
	}

	return t
}