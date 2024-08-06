# Determine the operating system
GOOS := $(shell go env GOOS)
GOARCH := $(shell go env GOARCH)

# Binary name
BINARY_NAME := oplog_parser
ifeq ($(GOOS),windows)
    BINARY_NAME := $(BINARY_NAME).exe
endif

.PHONY: all build clean test

all: build

build:
	@echo "Building binary for $(GOOS)/$(GOARCH)..."
	golangci-lint run
	go build -o $(BINARY_NAME) .

clean:
	@echo "Cleaning up..."
	go clean
	rm *.gob
	rm *.sql
	rm -f $(BINARY_NAME)

test:
	@echo "Running tests..."
	go test -v ./ ./transformer 