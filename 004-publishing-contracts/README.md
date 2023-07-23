# Publishing contracts

Now that you know how to write programs and debug gno code, let's get you started
publishing some smart contracts.

In `guestbook.gno`, you can see a simple application for a guestbook. If you did
not already set up your test1 wallet, it's a good time to do so: [follow
the instructions from the second example](../002-gnokey/README.md).

The advantage of using the `test1` key instead of your own key is that it has,
at genesis, a large number of tokens which can help us run transactions straight
off the bat.

From this directory (use the `cd` command in the shell to navigate
`004-publish-contracts`), run the following command:

```
gnokey maketx addpkg \
	--gas-wanted 1000000 \
	--gas-fee 1ugnot \
	--pkgpath gno.land/r/demo/guestbook \
	--pkgdir . \
	--broadcast \
	test1
```

## Browsing the contract

In the source code, there is a `Render` function. This enables us to browse the
smart contract through the `gnoweb` HTTP frontend.

From the simple browser in your Gitpod, browse to the path `/r/demo/guestbook`
(appending it to the Gitpod URL - so something like
`https://8888-gnolang-gettingstarted-lnw0x71frja.ws-eu102.gitpod.io/r/demo/guestbook`).
You will see a markdown rendering of the website, which works by executing the Render()
function.

As expected, there will be one single signature on the guestbook -- the one
defined in `var signatures`. Let's fix that and add a new one!

## Adding a new signature

If you click on the `[help]` link in the header, on the right, you
will also be able to see a list of the exported functions of the realm, and
instructions on how to execute them using `gnokey`.

By modifying the fields, you can interactively set up your `gnokey` command, and
make it say whatever you want it to.

![A screenshot of a simple configuration of gnokey, that we will use
later.](./screenshot.png)

Let's run that command:

```
gnokey maketx call \
	-pkgpath "gno.land/r/demo/guestbook" \
	-func "Sign" \
	-gas-fee 1000000ugnot \
	-gas-wanted 2000000 \
	-send "" \
	-broadcast \
	-chainid "dev" \
	-args "Hello world\! And hello, **bold**\!" \
	-remote "127.0.0.1:26657" \
	test1
```

The transaction should succeed, and if you browse again to the homepage of the
realm you should see your new post with your address. Ta-da! :tada:

## The magic of realms

We have glossed over an important concept of Gno for the sake of the tutorial:
how global variables work in realms. You may have noticed that in the source
code we declared a global variable, which contained the first signature:

```go
var signatures = []Signature{
	{
		Message: "You've reached the end of the guestbook!",
		Address: "",
		Time:    time.Date(2023, time.January, 1, 12, 0, 0, 0, time.UTC),
	},
}
```

This shows up when we browse the realm from the web, and all is good here.
However, after we call `Sign`, it stores the new signature in the global
variable, and suddenly -- poof! -- the signature appears in the guestbook.

```go
	// append new signature -- at the top of the list
	signatures = append([]Signature{{
		Message: message,
		Address: caller,
		Time:    time.Now(),
	}}, signatures...)
```

This is the magic of Gno realms -- they are **stateful.** This means that when
in a transaction you change a global variable, or any data stored within it, the
new data is automagically stored and persisted on the blockchain.

Because we're running in a blockchain context, as opposed to Go we can't have
things like network access, or access to the filesystem, or using
cryptographically random functions. These are all **non-deterministic,** meaning
that if you attempt to run the code twice, or on different machines, it may lead
to different results. Gno code, in contracts, like all other smart contracts,
must be **deterministic** and always have the same results if it's given the
same starting context -- which is why we provide global variables as a solution
for storing data.

### Deterministic time

The careful observer may note that `time.Now()` is not a deterministic value, as by
definition it is always changing and "should" be different each time the program
is executed. However, to enable the use of time.Now() in blockchain, this will
actually represent the _block time_.

In a blockchain, a new "block" is created after a given amount of time. This
will roughly match the current time; but note the value does not change during
the execution of the program, and as such `time.Now()` cannot be used to
benchmark a program -- it is just a rough idea of what time the transaction is
executed.

### The difference between realms and packages

As you've learned, realms have the distinctive feature of being able to persist
their global variables. The underlying idea here is that realms are end-user
smart contracts; which is why they also support the `Render()` function for
viewing their data on the web.

In `guestbook.gno`, however, we make an import of package
`gno.land/p/demo/ufmt`. This is an example of a _package_ (as opposed to a
_realm_) -- it is distinct from a realm because its import path starts with
`gno.land/p/` instead of `gno.land/r/`.[^1]

Packages behave like normal Go packages, or similar concepts of other
programming languages: they are reusable pieces of code which are meant as
"building blocks" to build complex software. They don't persist any data, nor
their functions can be executed as smart contracts.

## Keep going

There are two more challenges for you in `guestbook.gno`: you can find them in
the `TODO` comments.

The first one is to prevent a user from signing the guestbook more than once,
aborting the transaction entirely. In Gno, you can abort transactions by using
the `panic()` function.

<details>
	<summary>Sample solution (only if you're stuck!)</summary>

```go
for _, sig := range signatures {
	if sig.Address == caller {
		panic("you have already signed the guestbook!")
	}
}
```

</details>

The second one is to use the `gno.land/r/demo/users` realm to render usernames.
The `users` realm is a "username registry" which is used in
other example realms, like [`microblog`](https://github.com/gnolang/gno/tree/master/examples/gno.land/p/demo/microblog),
[`boards`](https://github.com/gnolang/gno/tree/master/examples/gno.land/p/demo/boards)
and [`groups`](https://github.com/gnolang/gno/tree/master/examples/gno.land/p/demo/groups).
You can inspect it and register yourself as a user of the realm.

We can make our guestbook nicer by referring to users using their username
instead of their address...

<details>
	<summary>Hint</summary>

To call other realms in Gno, we simply have to import them at the top of the
file in the `import` statement. After doing that, you can use the function
`users.GetUserByAddress` to see if there is a matching User.

</details>

<details>
	<summary>Sample solution (only if you're stuck!)</summary>

```go
// add import: "gno.land/r/demo/users"

func Render(string) string {
	b := new(strings.Builder)
	// gnoweb, which is the HTTP frontend we're using, will render the content we
	// pass to it as markdown.
	b.WriteString("# Guestbook\n\n")
	for _, sig := range signatures {
		if sig.Address == "" {
			sig.Address = "anonymous coward"
		} else if u := users.GetUserByAddress(sig.Address); u != nil {
			sig.Address = ufmt.Sprintf("[@%s](/r/demo/users:%s)",
				u.Name(), u.Name())
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
	}
	return b.String()
}
```

</details>

## Recap

1. By using the `gnokey maketx addpkg`, we can add a new package or realm to the
   blockchain.
2. Packages are reusable "building blocks" of code. Realms are "special
   packages" which:
   - Can persist state in their global variables
   - Can have their functions called as smart contracts, using `gnokey`
   - Can be rendered through the web frontend, using the special `Render` function
3. Using the `[help]` page of gnoweb, we can construct transactions to smart
   contracts we've created.
4. All Gno code must be deterministic and run exactly the same independent of
   the machine. We are still allowed to use `time.Now()` -- however that will
   actually return the block time instead of the machine's clock time.
5. We can make calls to other realms with their state by simply importing their
   path in our Gno code.

-----

[^1]: at the moment, all code uploaded to the chain must have an import path starting with either of the two.
