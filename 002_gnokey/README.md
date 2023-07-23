# Learn to Use Gnokey

`gnokey` is the command line tool for interacting with a blockchain node. It
allows you to make blockchain transactions, publish new packages, and in general
do any operation with a remote or local blockchain node.

We're going to start by importing a test wallet which has a lot of tokens --
allowing you to freely play around. We'll then show you how you can create your
own wallet, although it will have no keys by default on the devnet -- but it can
be useful to play around with the online testnet.

## Import the `test1` Wallet

To import the `test1` wallet (10^13ugnot in genesis), use the following command:

```console
gnokey add test1 --recover
```

Mnemonic:

```console
source bonus chronic canvas draft south burst lottery vacant surface solve popular case indicate oppose farm nothing bullet exhibit title speed wink action roast
```

Check:

```console
gnokey list
```

<details>
  <summary>Example...</summary>

```console
$ gnokey list

$ gnokey add test1 --recover
Enter a passphrase to encrypt your key to disk:
Repeat the passphrase:
Enter your bip39 mnemonic
source bonus chronic canvas draft south burst lottery vacant surface solve popular case indicate oppose farm nothing bullet exhibit title speed wink action roast

* test1 (local) - addr: g1jg8mtutu9khhfwc4nxmuhcpftf0pajdhfvsqf5 pub: gpub1pgfj7ard9eg82cjtv4u4xetrwqer2dntxyfzxz3pq0skzdkmzu0r9h6gny6eg8c9dc303xrrudee6z4he4y7cs5rnjwmyf40yaj, path: <nil>

$ gnokey list
0. test1 (local) - addr: g1jg8mtutu9khhfwc4nxmuhcpftf0pajdhfvsqf5 pub: gpub1pgfj7ard9eg82cjtv4u4xetrwqer2dntxyfzxz3pq0skzdkmzu0r9h6gny6eg8c9dc303xrrudee6z4he4y7cs5rnjwmyf40yaj, path: <nil>
```
</details>

## Create a New Personal Wallet

To create a new personal wallet, generate your 24 keywords with the command:

```console
gnokey generate
```

Then follow the instructions for `test1`, but use your chosen name, e.g., `bob`.

<details>
  <summary>Example...</summary>

```console
$ gnokey generate
meat middle doctor gasp axis drastic flower song test public hire title ivory walnut pledge violin mechanic hedgehog rapid satisfy measure autumn front blind

$ gnokey add bob --recover
Enter a passphrase to encrypt your key to disk:
Repeat the passphrase:
Enter your bip39 mnemonic
meat middle doctor gasp axis drastic flower song test public hire title ivory walnut pledge violin mechanic hedgehog rapid satisfy measure autumn front blind

* bob (local) - addr: g1h5tap94s8k0dhwhkldf39vavucvnjhrhepmt8a pub: gpub1pgfj7ard9eg82cjtv4u4xetrwqer2dntxyfzxz3pqdzdqdzjre7nfvtd7ge3gsenxsdf0ww2fcazt957q76glapsrxgeg774qj2, path: <nil>

$ gnokey list
0. bob (local) - addr: g1h5tap94s8k0dhwhkldf39vavucvnjhrhepmt8a pub: gpub1pgfj7ard9eg82cjtv4u4xetrwqer2dntxyfzxz3pqdzdqdzjre7nfvtd7ge3gsenxsdf0ww2fcazt957q76glapsrxgeg774qj2, path: <nil>
1. test1 (local) - addr: g1jg8mtutu9khhfwc4nxmuhcpftf0pajdhfvsqf5 pub: gpub1pgfj7ard9eg82cjtv4u4xetrwqer2dntxyfzxz3pq0skzdkmzu0r9h6gny6eg8c9dc303xrrudee6z4he4y7cs5rnjwmyf40yaj, path: <nil>
```
</details>

## Interact with the `r/demo/boards` Realm

Now that we have set up an account, let's try interacting with a smart contract.

```console
$ gnokey maketx call \
	-pkgpath "gno.land/r/demo/boards" \
	-func "CreateThread" \
	-gas-fee 1000000ugnot \
	-gas-wanted 2000000 \
	-send "100000000ugnot" \
	-broadcast \
	-chainid "dev" \
	-args "1" \
	-args "Hello world\!" \
	-args "Just fooling around with creating a new thread on r/demo/boards." \
	-remote "127.0.0.1:26657" test1
Enter password.
(7 gno.land/r/demo/boards.PostID)
OK!
GAS WANTED: 2000000
GAS USED:   1043320
```

If you click on `r/demo/boards` from the browser in the top-right corner of
Gitpod, and browse to testboard, you should now be able to see a "Hello world!"
post with the test1 address at the bottom of the page.
