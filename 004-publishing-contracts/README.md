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
