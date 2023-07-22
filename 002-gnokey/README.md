# Learn to use Gnokey

`gnokey` allows you to manage accounts and interact with gno.land instances, including a local devnet.

## Import the `test1` wallet

The `test1` wallet already has tokens on devnet and staging.



    gnokey add test1 --recover

Use this mnemonic:

    source bonus chronic canvas draft south burst lottery vacant surface solve popular case indicate oppose farm nothing bullet exhibit title speed wink action roast
    
Check:

    gnokey list

<details>
  <summary>Example...</summary>
  
```console
gitpod /workspace/getting-started (main) $ gnokey list

gitpod /workspace/getting-started (main) $ gnokey add test1 --recover
Enter a passphrase to encrypt your key to disk:
Repeat the passphrase:
Enter your bip39 mnemonic
source bonus chronic canvas draft south burst lottery vacant surface solve popular case indicate oppose farm nothing bullet exhibit title speed wink action roast

* test1 (local) - addr: g1jg8mtutu9khhfwc4nxmuhcpftf0pajdhfvsqf5 pub: gpub1pgfj7ard9eg82cjtv4u4xetrwqer2dntxyfzxz3pq0skzdkmzu0r9h6gny6eg8c9dc303xrrudee6z4he4y7cs5rnjwmyf40yaj, path: <nil>

gitpod /workspace/getting-started (main) $ gnokey list
0. test1 (local) - addr: g1jg8mtutu9khhfwc4nxmuhcpftf0pajdhfvsqf5 pub: gpub1pgfj7ard9eg82cjtv4u4xetrwqer2dntxyfzxz3pq0skzdkmzu0r9h6gny6eg8c9dc303xrrudee6z4he4y7cs5rnjwmyf40yaj, path: <nil>
```
</details>

## Create a new personal wallet

Let's create a completely new account now.

Come with your 24 keywords, or create ones using:

    gnokey generate

Follow instructions for `test1`, but use your own name, i.e., `bob`.

```console
gitpod /workspace/getting-started (main) $ gnokey generate
meat middle doctor gasp axis drastic flower song test public hire title ivory walnut pledge violin mechanic hedgehog rapid satisfy measure autumn front blind

gitpod /workspace/getting-started (main) $ gnokey add bob --recover
Enter a passphrase to encrypt your key to disk:
Repeat the passphrase:
Enter your bip39 mnemonic
meat middle doctor gasp axis drastic flower song test public hire title ivory walnut pledge violin mechanic hedgehog rapid satisfy measure autumn front blind

* bob (local) - addr: g1h5tap94s8k0dhwhkldf39vavucvnjhrhepmt8a pub: gpub1pgfj7ard9eg82cjtv4u4xetrwqer2dntxyfzxz3pqdzdqdzjre7nfvtd7ge3gsenxsdf0ww2fcazt957q76glapsrxgeg774qj2, path: <nil>

gitpod /workspace/getting-started (main) $ gnokey list
0. bob (local) - addr: g1h5tap94s8k0dhwhkldf39vavucvnjhrhepmt8a pub: gpub1pgfj7ard9eg82cjtv4u4xetrwqer2dntxyfzxz3pqdzdqdzjre7nfvtd7ge3gsenxsdf0ww2fcazt957q76glapsrxgeg774qj2, path: <nil>
1. test1 (local) - addr: g1jg8mtutu9khhfwc4nxmuhcpftf0pajdhfvsqf5 pub: gpub1pgfj7ard9eg82cjtv4u4xetrwqer2dntxyfzxz3pq0skzdkmzu0r9h6gny6eg8c9dc303xrrudee6z4he4y7cs5rnjwmyf40yaj, path: <nil>
```
</details>
