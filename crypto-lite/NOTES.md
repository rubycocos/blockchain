# Notes

## ToDos

- [ ] check that hash function always fill-up with leading zeros (0000)
       if number is smaller than 32-bytes? hex string always with 64 hex(adecimal) chars


## Chain Params


Coin Network Prefix Version Table:

      |  BIP 44    |      mainnet              |     mainnet     |     mainnet     |
Coin  | coin_type  |    version_WIF            |  version_p2pkh  |  version_p2sh   |
------|------------|-----------|---------------|-----------------|-----------------|
BTC   |      0     |        128 (or 0x80)      |   0 (or 0x00) => ('1')       |   5/('3')       |
TEST  |      1     |        239 (or 0xef)      | 111/('m' or 'n') | 196/('2')       |
LTC   |      2     |        176 (or 0xb0)      |  48/('L')       |   5/('3')       |
DOGE  |      3     |        158 (or 0x9e)      |  30 (or 0x1e) => ('D')       |  22/('9' or 'A') |


- <https://github.com/bitcoin/bitcoin/blob/master/src/chainparams.cpp>
- <https://github.com/litecoin-project/litecoin/blob/master/src/chainparams.cpp>
- <https://github.com/dogecoin/dogecoin/blob/master/src/chainparams.cpp>


Addresses:

- <https://dogecoin.fandom.com/wiki/Your_address>



## Articles

**Bitcoin**

- Tutorial - Address Generation - <https://www.royalfork.org/2014/07/31/address-gen/>
- Graphical Address Generator - <https://www.royalfork.org/2014/08/11/graphical-address-generator/>

- Bitcoin Gem
  - <https://github.com/lian/bitcoin-ruby/blob/master/lib/bitcoin/key.rb>


**Ethereum**

- Graphical Ethereum Address - <https://www.royalfork.org/2017/12/10/eth-graphical-address/>



## More Bitcoin Notes

How big (or how safe) is a (random) 256-bit (32 byte) integer number?

- How many sand grains on the beach?
- How many sand grains on earth?
- How many atoms in the universe?

Public key is the "raw" to the metal format.
Why not use it?

- Can we make it shorter?
- Can we make it more secure?
- Can we protect against typos?
- Can we add a checksum?

> There are currently three Bitcoin address formats in use:
>
> - P2PKH (Pay to public key hash) which begin with the number 1, eg: `1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVN2`.
> - P2SH (pay to script hash) type starting with the number 3, eg: `3J98t1WpEZ73CNmQviecrnyiWrnqRhWNLy`.
> - Bech32 type starting with bc1, eg: `bc1qar0srrr7xfkvy5l643lydnw9re59gtzzwf5mdq`.
>
> (Source: [Bitcoin address @ Bitcoin Wiki](https://en.bitcoin.it/wiki/Address))


What's Base 56 Encoding? What's Base 32 Encoding?

Alphabets - Base 16 (a.k.a. Hexadecimal), Base 32, Base 56:

- `123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz`
- `0123456789ABCDEF`
- `023456789acdefghjklmnpqrstuvwxyz`

Triva Quiz: What characters (digits/letters) are
missing in the base 32/base 56 alphabets?

- In Base 56   -  `0` (Zero), `O` (Upper-O), `I` (Upper-I), `l` (Lower-L)
- In Base 32 (Bitcoin Bech32 Version) - `1`, `B`, `I`, `O`

Why use base32 (and not base56)?

- The lack of mixed case makes it more efficient to read out loud or to put into QR codes.
  Base32 does come with a 15% length increase (compared to base56).
- Base58 needs a lot of space in QR codes, as it cannot use the alphanumeric mode.
  Alphanumeric mode used by base32 (with uppercase letters)
  is 45% more compact than the normal byte mode.





## Ideas
- [] add RSA to readme - why? why not?

**RSA - Rivest, Shamir and Adleman**



``` ruby
alice_key, alice_pub =  RSA.generate_keys

alice_key
#=> "-----BEGIN RSA PRIVATE KEY-----
#    MIIEpAIBAAKCAQEAzLpmAQ+MbUTHU1XxzEaQXqiOvk0Vu/skztaMWz+UoGYWU6eW
#    cr7zVt/Y0SYqzD8LkYireX22FxNNFfhgu3/uC5yTl+dri6PD6NDAmrG+1cyE8kZZ
#    MGq91wQEemZPuesjTgKEvwZbknjodIKOAP35QycMr4PuWICSrCjhJLrClI7jInTZ
#    LOLtD5w5U7/xLOJAIfuhjUA4wrFCLJGPe7214KWgDCLmsan4/GVUloUKa6KAHJiH
#    q4tNxNdSrbOlluZbKQl8REhXOCIb5bEX2KnbQT0nPgKkuOlXgZ7jeyOIk0FG1RGa
#    FvcGu8LieMgT39WltcHJLblNkDr9YDRGiNiThQIDAQABAoIBAQCE/FPEPqBeXj4I
#    MRzHL9MZ2e4XSaVjnYjUXuN/ZnaaFpZMMuF0mfshpHiHq35DfHR8TcXtPi6pIJ2D
#    NvtG8JvlqQjqtKXUaEWbFvb1xZ4L7TUy12WaIMw+PlrWU11YjJg7VUF7gJq9M5L0
#    E9ZAaLmg2F3SKSYLEUG1WTyeij5ZFqouNjZxD2xo5U5Agy2UVm2D9aUm/n4g8Wnr
#    HybadhD6V9+BsZ2e9Q6CamHRah9Hs4nDPnycPFXpbs32wx9nvACPMg5+/Fqxr/ZK
#    cPM4syVBW0lNhpTzhHkPvimAgwgqJYvAj/o9nQnq5i1XyVyXp3uKVnld3FCddf9i
#    ovQMPmVlAoGBAPHtUKRehy8df/Zw6oGz0WcZCTjEwZ9DEb5rFN9Pr2IyvOhmZ3UJ
#    JNx9WmiiGB44dbnafMtr2Ya7u4OAM6e190BbcJKTnpWqVlsXw/wyQqIgJb3AtFu4
#    91mqsDepOWsfs1IjTgmR1OM29WXjGoPHtV9E6//uVmVsciEvkCtcRfGDAoGBANij
#    IbZ3mL1rr8uRT/czPLkZ3KPLsJhPriuc6yyOq+tqQ6d3u/1DjKxoeYa7Jbyj7Dwl
#    2wHQf9vRz3Kb2Mw+hPcHGDO9aBWxvZXjxxrVk6g1Ei0mvIP0k8ZbnlReK3cr5ktl
#    aY/ZWDDVPpY4aqkcOIbAAi95jPlpb2LsntijxoBXAoGABPJRP8sfAHud7jAI23YN
#    xgnhAmQjgVohtr8Bwj8i2uMmsanGW8JAGrIFczY9QADvh0lMW+xsmjCkeN/aLoet
#    8obsGlMiXvUIpvwpabKtYhs+Kk8SYP27MP4odDrljacsR3WpVtDAhZTOF7M5C5C9
#    yKDkImuBILnC66LJU9mjJHkCgYEAntDxDSCeQ/dnOBh+hB323UgdXaMdAnwflm+C
#    ZPbvCDWuBV6c3W2g+l/Y/7HBV4rgy7OA29KreU5WA5JHHGyU87gqwPuRC55y+yiy
#    NXTvu7e0bI9iUmaB00AlUXp76PCw8wMUoVVX9uzN5jjT0MgUlIy8zWsRs2LdOqt3
#    RCDEjB8CgYAO6ZptzyJ4FS7ucjKfjig5WMOiKMcIUtTG9qedHmE2Z6vt3g0SQWaD
#    zJJacSoRHAdRK61vOlg4k+9/9LjffDrk9uT555BDbYqKWlmST7JMfvO7EpaIMYUu
#    CN7+3Rx9gSLyScqtAYiT/LgYgL1Vc6/e0XHaVjA85kPvUDKb785oFg==
#    -----END RSA PRIVATE KEY-----"

alice_pub
#=> "-----BEGIN PUBLIC KEY-----
#    MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAzLpmAQ+MbUTHU1XxzEaQ
#    XqiOvk0Vu/skztaMWz+UoGYWU6eWcr7zVt/Y0SYqzD8LkYireX22FxNNFfhgu3/u
#    C5yTl+dri6PD6NDAmrG+1cyE8kZZMGq91wQEemZPuesjTgKEvwZbknjodIKOAP35
#    QycMr4PuWICSrCjhJLrClI7jInTZLOLtD5w5U7/xLOJAIfuhjUA4wrFCLJGPe721
#    4KWgDCLmsan4/GVUloUKa6KAHJiHq4tNxNdSrbOlluZbKQl8REhXOCIb5bEX2Knb
#    QT0nPgKkuOlXgZ7jeyOIk0FG1RGaFvcGu8LieMgT39WltcHJLblNkDr9YDRGiNiT
#    hQIDAQAB
#    -----END PUBLIC KEY-----"

bob_key, bob_pub = RSA.generate_keys

bob_key
#=> "-----BEGIN RSA PRIVATE KEY-----
#    MIIEpAIBAAKCAQEAzADannvKlfVkZmKA4EDIxTW0HiJzjD6Auh8wLi02+iz2BScz
#    fECA65Zv+KHfc1B9AWMqGeBIwFE49NrsnXiZwZR3DqcFS8WbnVqpntvhwzlEARna
#    RWmZ2XjloD7fxILbXtWfMFNjwSfaK0bpArLkrt9d8eni+JI42+ptIWs/bVynACqm
#    DqOTjoEgajuHVpxHtskPNQrsjxzP+umsUWkbE0iaO7oN1pcgZIR4VRr0bz/3Juif
#    WmiCgwbDZo1WolfveoCacVsfAB1iesxeWnrGIJUjq8Mqsu9mQz1dg6RF4ElwNJ57
#    G3T3nlW+qpVBZDU2sHFqUFxbGmWPdRUn1yn4KwIDAQABAoIBAQCOCwotz4P/Zh3C
#    LFQP0Qv6RKplURejTuHStmSVwmXFTAkBDYqLuV4Kq3TLaepsIF7p2GI4IjKFtggy
#    dTzLaG2mm/lJ+oF1gOIZbkcslW1cwULYgWe5bQ3ynntEWIL2ESctoRB2VZnfpCAE
#    ghs8BdO071I6Xt/qs+VjOpdB7ar8OYhFc1vhwiI03FKbjuScH0CQOETIeLCqK5tC
#    qPnjMTYdaTp/NgcZujsOeOBgbARLzGtCaESbmXHO6mPDkEED5uqZzsNBtdCZIGMF
#    ApJkZbF6xSRizQhwwRlak1jCkAk2VCYpKPMiop1+cbjs3jU3RyP94RHc/yKo2Rzm
#    HCl35XYBAoGBAPJDMV9W2scRsMlLw9In3ZzWtammcouE0oXEgizK61Cg/5C5E06a
#    5anrfwF5bURBANKBqTSHV0u71C2fHs1KO+B+EHzQ4DKsXldCSv2PR/0A6lmF9AIL
#    DFfup/mU55plbqCnjJe2BOUrOmurSd5MbWtShRdGri/LBqF58BFgT+U1AoGBANeS
#    RZDsCWelZPGN8Wxp9zxhu1AClNO9S7ITjZOQTYlghCVKAkS1wvB/6TIjaw8DyREs
#    f6WvtkzQA/vZc4mXE+YM/calL8ee3wVEJJzlGBfuh8mQhxtiLa5PTl7Icv/R8DGV
#    9hU9GkJgWdi/+Plpqdcv79OWVMTB7igmoN8PAPPfAoGAKqatwI04AygYKbhPB2bB
#    W2Vpoi6NqAaAUdCg4mXvO8i8daw/u+0FVf8B4y6PkB6pmGX/diIFum2dE1MaRyY0
#    mHdZS8AyWHmEOnSPY0igceiBWbV9mgZ769c2d3hBtir5aQtWczc2cWpE5MPJQ3vN
#    H8HtcIWfEQb7ad5f548/QakCgYEAwFDjNRYOkePQ+Vrbjg+/HKRH+mpDId9Xv4eI
#    H6R2N9/eJHIxMeFCB1Ll1PAaG6wR3ftn6YWnykEtvKpTU+VvQCZI5MYLqTgH2Ofh
#    DgOoCfmoNF922SwuerqPvSlwxt8hPOt/PZVkbuEMZr1lPgVRGwPOHmKYP2yPrkw/
#    6p+1BtsCgYABmMLgWhXVD19XxNHm8XpGnPWTEjqAYrw6I5yDUwNhB0n4129qaC+x
#    MWrdslKBmQh1r1U5QoSSL0CY4Ef5qN02uZl15FN1kYQzZA6kJi+MoBsjzrZCvzsc
#    Bbahpg363PyHC75zgvazvOr4tK3mzaRi5RNTMgivTVu4FyhkRdJ5wQ==
#    -----END RSA PRIVATE KEY-----"

bob_pub
#=> "-----BEGIN PUBLIC KEY-----
#    MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAzADannvKlfVkZmKA4EDI
#    xTW0HiJzjD6Auh8wLi02+iz2BSczfECA65Zv+KHfc1B9AWMqGeBIwFE49NrsnXiZ
#    wZR3DqcFS8WbnVqpntvhwzlEARnaRWmZ2XjloD7fxILbXtWfMFNjwSfaK0bpArLk
#    rt9d8eni+JI42+ptIWs/bVynACqmDqOTjoEgajuHVpxHtskPNQrsjxzP+umsUWkb
#    E0iaO7oN1pcgZIR4VRr0bz/3JuifWmiCgwbDZo1WolfveoCacVsfAB1iesxeWnrG
#    IJUjq8Mqsu9mQz1dg6RF4ElwNJ57G3T3nlW+qpVBZDU2sHFqUFxbGmWPdRUn1yn4
#    KwIDAQAB
#    -----END PUBLIC KEY-----"


tx = "from: alice, to: bob,  $21"
tx_hash = sha256( tx )
#=> "426a472a6c69bf68354391b7822393bea3952cde9df8949ad7a0f5f405b2fcb5"

tx_signature = RSA.sign( tx_hash, alice_key )
#=> "xfhzC6tzXYmA5rFAFybJ9KeWnTcTnC0Plt7cSHky6ZSdBZRKz/sfFcpyIN7w
#    jWrdPwEREA3nwNu/HSpiGRBFr+lu/YgWGNp6HLGPeL7uHGAfmWPyU5WRzGzf
#    iEs5B6kdJ3S8LSbP0hkOD8AOgZLPeU5rzA4+/Ymt8e/UOVwwka6Gj13yoBua
#    mSdsVuQfgh2VpySejCz4ykYlMSHK8Kx8QFt+QbyI5QZUy2dFh6HlcnHR+G9A
#    RMRZ1vAuQhYqtDSsxwRcZCSFsc6uctAvsgFinhqy6ls5VpcXfuKwZhKAw3Di
#    E2MYUnT7+i38Mq26iWzgmDbpOrVCO5tjlSiHY1731A=="

RSA.valid_signature?( tx_hash, tx_signature, alice_pub )
#=> true

tx = "from: alice, to: bob,  $22"
tx_hash = sha256( tx )
#=> "e899604bb4c95d2f1a7cfe561ad65941769e2064bdbbcaa79eb64ce0a2832380"

RSA.valid_signature?( tx_hash, tx_signature, alice_pub )
#=> false
```


and some more.




