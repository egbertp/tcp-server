BINARY=tcp-server
VERSION_TAG=`git describe 2>/dev/null | cut -f 1 -d '-' 2>/dev/null`
COMMIT_HASH=`git rev-parse --short=8 HEAD 2>/dev/null`
BUILD_TIME=`date +%FT%T%z`
LDFLAGS=-ldflags "-s -w \
	-X main.CommitHash=${COMMIT_HASH} \
	-X main.BuildTime=${BUILD_TIME} \
	-X main.VersionTag=${VERSION_TAG}"

all: build

clean:
	go clean
	if [ -f ${BINARY} ] ; then rm ${BINARY} ; fi
	rm -rf ./target || true

release: clean linux darwin windows

# Installs our project: copies binaries
install:
	go install ${LDFLAGS}

build:
	if [ -f ${BINARY} ] ; then rm ${BINARY} ; fi
	go build -o ${BINARY} ${LDFLAGS}

linux:
	GOOS=linux GOARCH=386 go build ${LDFLAGS} -o ./target/linux_386/${BINARY}-linux-386
	GOOS=linux GOARCH=amd64 go build ${LDFLAGS} -o ./target/linux_amd64/${BINARY}-linux-amd64

darwin:
	GOOS=darwin GOARCH=386 go build ${LDFLAGS} -o ./target/darwin_386/${BINARY}-osx-386
	GOOS=darwin GOARCH=amd64 go build ${LDFLAGS} -o ./target/darwin_amd64/${BINARY}-osx-amd64

windows:
	GOOS=windows GOARCH=386 go build ${LDFLAGS} -o ./target/windows_386/${BINARY}-win-386.exe
	GOOS=windows GOARCH=amd64 go build ${LDFLAGS} -o ./target/windows_amd64/${BINARY}-win-amd64.exe


.PHONY: build