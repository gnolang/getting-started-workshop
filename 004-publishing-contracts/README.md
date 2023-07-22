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

From the browser in your Gitpod, browse to <http://localhost:8888/r/demo/guestbook>.
You will see a markdown rendering of the website, by executing the Render()
function. If you click on the `[help]` link in the header, on the right, you
will also be able to see a list of the exported functions of the realm, and
instructions on how to execute them using `gnokey`.
