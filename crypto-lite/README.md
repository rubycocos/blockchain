# crypto-lite - Cryptographic Secure Hash Functions and Public Key Signature Algorithms Made Easy



* home  :: [github.com/rubycoco/blockchain](https://github.com/rubycoco/blockchain)
* bugs  :: [github.com/rubycoco/blockchain/issues](https://github.com/rubycoco/blockchain/issues)
* gem   :: [rubygems.org/gems/crypto-lite](https://rubygems.org/gems/crypto-lite)
* rdoc  :: [rubydoc.info/gems/crypto-lite](http://rubydoc.info/gems/crypto-lite)


## Usage

### Secure Hashing / Hash Functions

**SHA256 - Secure Hash Algorithm (SHA) 256-Bit (32 Bytes)**


``` ruby
require 'crypto'      ## or use require 'crypto-lite'

## try abc
sha256( "abc" )           #=> "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad"
sha256( "abc".b )         #=> "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad"
sha256( "\x61\x62\x63" )  #=> "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad"
sha256( 0x616263 )        #=> "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad"

sha256( hex: '616263' )     #=> "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad"
sha256( hex: '0x616263' )   #=> "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad"
sha256( hex: '0X616263' )   #=> "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad"

# "auto-magic" hex string to binary string conversion heuristic
sha256( '0x616263' )      #=> "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad"
sha256( '0X616263' )      #=> "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad"
```


Bonus Back Stage Tip: How does SHA256 work?

Try this [amazing animation of the SHA256 hash function in your very own terminal](https://github.com/in3rsha/sha256-animation) by Greg Walker.



Onwards with more sha256 examples:

``` ruby
## try a
sha256( "a" )         #=> "ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb"
sha256( "\x61" )      #=> "ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb"
sha256( 0b01100001 )  #=> "ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb"
sha256( 0x61 )        #=> "ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb"

sha256( hex: '61' )     #=> "ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb"
sha256( hex: '0x61' )   #=> "ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb"

# "auto-magic" hex string to binary string conversion heuristic
sha256( '0x61' )      #=> "ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb"


## try some more
sha256( "Hello, Cryptos!" )  #=> "33eedea60b0662c66c289ceba71863a864cf84b00e10002ca1069bf58f9362d5"
```


**SHA3-256 - Secure Hashing Algorthim (SHA) 3, 256-Bit (32 Bytes)**

``` ruby
sha3_256( "Hello, Cryptos!" )  #=> "7dddf4bc9b86352b67e8823e5010ddbd2a90a854469e2517992ca7ca89e5bd58"
```

Note:  Yes, SHA256 vs SHA3-256 / SHA-2 vs SHA-3 the hashing functions are
different (although the 256-bit hash size output is the same).
The sha256 hashing function is part of the Secure Hash Algorithm (SHA) 2 family / standards first published in 2001.
The sha3_256 is part of the (newer) Secure Hash Algorithm (SHA) 3 family / standards first published in 2015
(and uses the Keccak cryptographic primitive "under the hood").



**Keccak 256-Bit**

``` ruby
keccak256( "Hello, Cryptos!" )  #=> "2cf14baa817e931f5cc2dcb63c889619d6b7ae0794fc2223ebadf8e672c776f5"
```


#### Aside - Keccak vs SHA3 / Original vs Official

In 2004 the U.S. National Institute of Standards and Technology (NIST)
changed the padding to `SHA3-256(M) = KECCAK [512] (M || 01, 256)`.
This is different from the padding proposed by the Keccak team in
the original Keccak SHA-3 submission version 3 (the final, winning version).
The difference is the additional `'01'` bits appended to the message.

To help avoid confusion the "submitted original version 3" SHA-3 Keccak
hashing is now called "Keccak"
and the finalized NIST SHA-3 standard "SHA3".

Tip: If you don't know what variant of the hash function you have -
original or official? - check your hash:

For keccak 256-bit:

``` ruby
keccak256( '' )   #=> "c5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470"
```

For sha3 256-bit:

``` ruby
sha3_256( '' )   #=> "a7ffc6f8bf1ed76651c14756a061d662f580ff4de43b49fa82d80a4b80f8434a"
```



**RMD / RIPE-MD  - RACE¹ Integrity Primitives Evaluation Message Digest 160-Bit**

¹: Research and development in Advanced Communications technologies in Europe


``` ruby
rmd160( "Hello, Cryptos!" )     #=>"4d65f7b740bbade4097e1348e15d2a7d52ac5f53"
# or use the alias / alternate name
ripemd160( "Hello, Cryptos!" )  #=>"4d65f7b740bbade4097e1348e15d2a7d52ac5f53"
```


#### Aside - Hex String `"0x616263"` vs Binary String `"\x61\x62\x63" == "abc"`

Note: All hash functions operate on binary strings ("byte arrays")
and NOT hex strings.

Note: For hex strings the `0x` or `0X` prefix is optional.
Examples of hex strings:

``` ruby
# hex string      binary string ("byte array")
"61"              "\x61" == "a"
"0x61"            "\x61" == "a"

"616263"          "\x61\x62\x63" == "abc"
"0x616263"        "\x61\x62\x63" == "abc"
"0X616263"        "\x61\x62\x63" == "abc"

# or   160-bit hex string (hash)
"93ce48570b55c42c2af816aeaba06cfee1224fae"
"0x93ce48570b55c42c2af816aeaba06cfee1224fae"

# or 256-bit hex string (hash)
"ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad"
"0xba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad"
```

You can use `[str].pack( 'H*' )`
to convert a hex string into a binary string.
Note: The standard `Array#pack` conversion
will NOT "auto-magically" cut-off the `0x` or `0X` prefix.


If you know you have a hex string use the `hex:` keyword to pass
in the arg(ument)
to the hash function and that will "automagically"
handle the hex-to-bin conversion for you. Example:

``` ruby
sha256( hex: '61' )     #=> "ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb"
sha256( hex: '0x61' )   #=> "ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb"

sha256( hex: '616263' )     #=> "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad"
sha256( hex: '0x616263' )   #=> "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad"
sha256( hex: '0X616263' )   #=> "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad"
```

What about the built-in "auto-magic" hex-to-bin conversion / heuristic?

Yes, if your passed in string starts with the
the `0x` or `0X` prefix the string gets "auto-magically" converted
to binary. Or if your passed in string is all hexadecimal characters,
that is, `0-9` and `a-f` and has a minimum length of ten characters.
Example:


``` ruby
# "auto-magic" hex string to binary string conversion heuristic

sha256( '0x616263' )      #=> "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad"
sha256( '0X616263' )      #=> "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad"

# or without 0x or 0X BUT with minimum heuristic length
hash160( '02b4632d08485ff1df2db55b9dafd23347d1c47a457072a1e87be26896549a8737' )
#=> "93ce48570b55c42c2af816aeaba06cfee1224fae"

hash256( '6fe6b145a3908a4d6616b13c1109717add8672c900' )
#=> "02335f08b8fe4ddad263a50b7a33c5d38ea1cbd8fd2056a1320a3ddece541711"

# and so on
```


#### Hash Function Helpers

**HASH160 -  RMD160(SHA256(X))**

All-in-one "best-of-both-worlds" helper - first hash with sha256 and than hash with rmd160. Why?  Get the higher security of sha256 and the smaller size of rmd160.


``` ruby
hash160( '02b9d1cc0b793b03b9f64d022e9c67d5f32670b03f636abf0b3147b34123d13990' )
#=> "e6b145a3908a4d6616b13c1109717add8672c900"

hash160( '02b4632d08485ff1df2db55b9dafd23347d1c47a457072a1e87be26896549a8737' )
#=> "93ce48570b55c42c2af816aeaba06cfee1224fae"
```


**HASH256 -  SHA256(SHA256(X))**

All-in-one double sha256 hash helper, that is, first hash with sha256 and than hash with sha256 again. Why?  Arguably higher security.

> SHA256(SHA256(X)) was proposed by Ferguson and Schneier in their excellent book "Practical Cryptography"
> (later updated by Ferguson, Schneier, and Kohno and renamed "Cryptography Engineering") as a way to make SHA256 invulnerable
> to "length-extension" attack. They called it "SHA256D".


``` ruby
hash256( '6fe6b145a3908a4d6616b13c1109717add8672c900' )
#=> "02335f08b8fe4ddad263a50b7a33c5d38ea1cbd8fd2056a1320a3ddece541711"
```

#### Base58 Encoding / Decoding Helpers

**BASE58**

Base58 encoding / decoding with leading zero bytes (in hex or binary strings) getting encoded from `00` to `1` and back:

``` ruby
base58( "516b6fcd0f" )    #=> "ABnLTmg"
base58( "00000000000000000000123456789abcdef0" )   #=> "111111111143c9JGph3DZ"
# or with optional 0x or 0X prefix
base58( "0x516b6fcd0f" )  #=> "ABnLTmg"
base58( "0x00000000000000000000123456789abcdef0" ) #=> "111111111143c9JGph3DZ"

unbase58( "ABnLTmg" )  #=> "516b6fcd0f"
unbase58( "111111111143c9JGph3DZ" ) #=> "00000000000000000000123456789abcdef0"
```


**BASE58CHECK -  BASE58(X || SHA256(SHA256(X))[:4])**

Base58 encoding with an extra 4-byte secure hash checksum.

``` ruby
base58check( "516b6fcd0f" )  #=> "237LSrY9NUUas"
base58check( "00f54a5851e9372b87810a8e60cdd2e7cfd80b6e31" ) #=> "1PMycacnJaSqwwJqjawXBErnLsZ7RkXUAs"

unbase58check( "237LSrY9NUUas" )   #=> "516b6fcd0f"
unbase58check( "1PMycacnJaSqwwJqjawXBErnLsZ7RkXUAs" )   #=> "00f54a5851e9372b87810a8e60cdd2e7cfd80b6e31"
```



### Public Key Signature Algorithms

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





## Examples

### Generate the Bitcoin (Base58) Address from the (Elliptic Curve) Public Key

Let's follow the steps from [How to create Bitcoin Address](https://en.bitcoin.it/wiki/Technical_background_of_version_1_Bitcoin_addresses#How_to_create_Bitcoin_Address):

``` ruby
# Lets start with the public key ("raw" hex string encoded)
pk = "0250863ad64a87ae8a2fe83c1af1a8403cb53f53e486d8511dad8a04887e5b2352"

# 1. Perform SHA-256 hashing on the public key
step1 = sha256( pk )
#=> "0b7c28c9b7290c98d7438e70b3d3f7c848fbd7d1dc194ff83f4f7cc9b1378e98"

# 2. Perform RIPEMD-160 hashing on the result of SHA-256
step2 = ripemd160( step1 )
#=> "f54a5851e9372b87810a8e60cdd2e7cfd80b6e31"

# 3. Add version byte in front of RIPEMD-160 hash (0x00 for Main Network)
step3 = "00" + step2
#=> "00f54a5851e9372b87810a8e60cdd2e7cfd80b6e31"

# 4. Perform SHA-256 hash on the extended RIPEMD-160 result
step4 = sha256( step3 )
#=> "ad3c854da227c7e99c4abfad4ea41d71311160df2e415e713318c70d67c6b41c"

# 5. Perform SHA-256 hash on the result of the previous SHA-256 hash
step5 = sha256( step4 )
#=> "c7f18fe8fcbed6396741e58ad259b5cb16b7fd7f041904147ba1dcffabf747fd"

# 6. Take the first 4 bytes of the second SHA-256 hash. This is the address checksum
step6 = step5[0..7]      # note: 4 bytes in hex string are 8 digits/chars
#=> "c7f18fe8"

# 7. Add the 4 checksum bytes from step 6 at the end of
#    extended RIPEMD-160 hash from step 3.
#    This is the 25-byte binary Bitcoin Address.
step7 = step3 + step6
#=> "00f54a5851e9372b87810a8e60cdd2e7cfd80b6e31c7f18fe8"

# 8. Convert the result from a byte string into a base58 string using Base58 encoding.
#  This is the most commonly used Bitcoin Address format.
addr  = base58( step7 )
#=> "1PMycacnJaSqwwJqjawXBErnLsZ7RkXUAs"
```

Or let's try again with the shortcut helpers:

- `HASH160     -  RMD160(SHA256(X))`
- `BASE58CHECK -  BASE58(X || SHA256(SHA256(X))[:4])`

``` ruby
# Lets start with the public key ("raw" hex string encoded)
pk = "0250863ad64a87ae8a2fe83c1af1a8403cb53f53e486d8511dad8a04887e5b2352"

# 1. Perform HASH-160 hashing on the public key
#    a) Perform SHA-256 hashing on the public key
#    b) Perform RIPEMD-160 hashing on the result of SHA-256
step1 = hash160( pk )
#=> "f54a5851e9372b87810a8e60cdd2e7cfd80b6e31"

# 2. Add version byte in front of RIPEMD-160 hash (0x00 for Main Network)
step2 = "00" + step1
#=> "00f54a5851e9372b87810a8e60cdd2e7cfd80b6e31"

# 3. Encode with BASE58CHECK
#    a) Perform SHA-256 hash on the extended RIPEMD-160 result
#    b) Perform SHA-256 hash on the result of the previous SHA-256 hash
#    c) Take the first 4 bytes of the second SHA-256 hash. This is the address checksum
#    d) Add the 4 checksum bytes at the end of
#       extended RIPEMD-160 hash from step 2.
#       This is the 25-byte binary Bitcoin Address.
#    e) Convert the result from a byte string into a base58 string
#       using Base58 encoding.
#       This is the most commonly used Bitcoin Address format.
addr  = base58check( step2 )
#=> "1PMycacnJaSqwwJqjawXBErnLsZ7RkXUAs"
```


References

- [How to create Bitcoin Address](https://en.bitcoin.it/wiki/Technical_background_of_version_1_Bitcoin_addresses#How_to_create_Bitcoin_Address)
- [Ruby Quiz #15 - Generate the Bitcoin (Base58) Address from the (Elliptic Curve) Public Key](https://github.com/planetruby/quiz/tree/master/015)

Bonus:  Bitcon Tip - How to Buy Bitcoin (The CO₂-Friendly Way)

> 1. Take one $50 bill, five $10 bills, or ten $5 bills (I wouldn't recommend change - stay with paper money).
> 2. Go to the bathroom.
> 3. Lift the lid of the loo.
> 4. Throw money in.
> 5. Flush down water.
>
> Congrats! You just purchased $50 worth of Bitcoin - without fucking the planet!
>
>  -- Trolly McTrollface, Bitcon Greater Fool Court Jester

Read more [Crypto Quotes »](https://github.com/openblockchains/crypto-quotes)




## Install

Just install the gem:

    $ gem install crypto-lite


## License

The scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.


## Questions? Comments?

Send them along to the [wwwmake forum](http://groups.google.com/group/wwwmake).
Thanks!

