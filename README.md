# TCP server

This GoLang mini-project creates a binary file that listens on an tcp address writes the output to the stdout.

I use this `tcp-server` project to verify the correct working of my infrastructure.

## Usage

Download:

```
mkdir $GOPATH/src/github.com/egbertp/tcp-server
cd $GOPATH/src/github.com/egbertp/tcp-server
git clone https://github.com/egbertp/tcp-server.git
```

### Build and Run

Build the binary
```
$ make build
```

Release the app
```
$ make release
```

Run the app
```
$ ./tcp-server
```

### Use tha app

```
telnet localhost 7000

2017/08/01 17:58:38 Starting TCP server on address: 0.0.0.0:7000
2017/08/01 17:58:42 Test
2017/08/01 17:58:45 next
2017/08/01 17:58:46 message
```