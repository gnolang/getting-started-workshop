install:
	@# install using go.mod
	go install github.com/gnolang/gno/gnovm/cmd/gno

bumpdeps:
	go get github.com/gnolang/gno@latest
	go mod tidy
