// Realm guestbook is a smart contract to register presences at a workshop.
// Participants to the workshop can add their own signature by calling the [Sign]
// contract.
package guestbook

import (
	"std"
	"strings"
	"time"

	"gno.land/p/demo/ufmt"
)

type Signature struct {
	Message string
	Address std.Address
	Time    time.Time
}

var signatures = []Signature{
	{
		Message: "You've reached the end of the guestbook!",
		Address: "",
		Time:    time.Date(2023, time.January, 1, 12, 0, 0, 0, time.UTC),
	},
}

// Sign adds a new signature to the guestbook
func Sign(message string) {
	// AssertOriginCall makes it possible to call Sign only as a transaction - ie.
	// it cannot be executed as a function, or called from other realms.
	std.AssertOriginCall()
	// caller, type std.Address, is the address of who has called this contract.
	caller := std.GetOrigCaller()

	// TODO: make sure caller hasn't signed the guestbook already

	// append new signature -- at the top of the list
	signatures = append([]Signature{{
		Message: message,
		Address: caller,
		Time:    time.Now(),
	}}, signatures...)
}

// Render is called when running the realm through gnoweb, and allows to render
// the realm's internal data, without the possibility of changing it.
//
// Render accepts a string, which is a "request path" -- similar to an HTTP
// request. We will be further exploring this at a later time, for now the
// argument is ignored.
func Render(string) string {
	b := new(strings.Builder)
	// gnoweb, which is the HTTP frontend we're using, will render the content we
	// pass to it as markdown.
	b.WriteString("# Guestbook\n\n")
	for _, sig := range signatures {
		if sig.Address == "" {
			sig.Address = "anonymous coward"
		}
		// We currently don't have a full fmt package; we have "ufmt" to do basic formatting.
		// See `gno doc ufmt` for more information.
		//
		// If you are unfamiliar with Go time formatting, it is done by writing the way you'd
		// format a reference time. See `gno doc time.Layout` for more information.
		b.WriteString(ufmt.Sprintf(
			"%s\n\n_written by %s at %s_\n\n----\n\n",
			sig.Message, string(sig.Address), sig.Time.Format("2006-01-02"),
		))

		// TODO: resolve sig.Address to a username, by using the r/demo/users realm.
	}
	return b.String()
}
