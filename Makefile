install:
	@# install using go.mod
	go mod download
	go install github.com/gnolang/gno/gnovm/cmd/gno
	go install github.com/gnolang/gno/gno.land/cmd/gnokey
