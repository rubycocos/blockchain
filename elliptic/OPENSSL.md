# OpenSSL Notes

## Links

- <https://en.wikipedia.org/wiki/OpenSSL>


## Command Line

### openssl help

```
Standard commands
asn1parse         ca                ciphers           cms
crl               crl2pkcs7         dgst              dhparam
dsa               dsaparam          ec                ecparam
enc               engine            errstr            gendsa
genpkey           genrsa            help              list
nseq              ocsp              passwd            pkcs12
pkcs7             pkcs8             pkey              pkeyparam
pkeyutl           prime             rand              rehash
req               rsa               rsautl            s_client
s_server          s_time            sess_id           smime
speed             spkac             srp               storeutl
ts                verify            version           x509

Message Digest commands (see the `dgst' command for more details)
blake2b512        blake2s256        gost              md4
md5               mdc2              rmd160            sha1
sha224            sha256            sha3-224          sha3-256
sha3-384          sha3-512          sha384            sha512
sha512-224        sha512-256        shake128          shake256
sm3

Cipher commands (see the `enc' command for more details)
aes-128-cbc       aes-128-ecb       aes-192-cbc       aes-192-ecb
aes-256-cbc       aes-256-ecb       aria-128-cbc      aria-128-cfb
aria-128-cfb1     aria-128-cfb8     aria-128-ctr      aria-128-ecb
aria-128-ofb      aria-192-cbc      aria-192-cfb      aria-192-cfb1
aria-192-cfb8     aria-192-ctr      aria-192-ecb      aria-192-ofb
aria-256-cbc      aria-256-cfb      aria-256-cfb1     aria-256-cfb8
aria-256-ctr      aria-256-ecb      aria-256-ofb      base64
bf                bf-cbc            bf-cfb            bf-ecb
bf-ofb            camellia-128-cbc  camellia-128-ecb  camellia-192-cbc
camellia-192-ecb  camellia-256-cbc  camellia-256-ecb  cast
cast-cbc          cast5-cbc         cast5-cfb         cast5-ecb
cast5-ofb         des               des-cbc           des-cfb
des-ecb           des-ede           des-ede-cbc       des-ede-cfb
des-ede-ofb       des-ede3          des-ede3-cbc      des-ede3-cfb
des-ede3-ofb      des-ofb           des3              desx
rc2               rc2-40-cbc        rc2-64-cbc        rc2-cbc
rc2-cfb           rc2-ecb           rc2-ofb           rc4
rc4-40            seed              seed-cbc          seed-cfb
seed-ecb          seed-ofb          sm4-cbc           sm4-cfb
sm4-ctr           sm4-ecb           sm4-ofb           zlib
```


### openssl help dgst

```
Usage: dgst [options] [file...]
  file... files to digest (default is stdin)
 -help               Display this summary
 -list               List digests
 -c                  Print the digest with separating colons
 -r                  Print the digest in coreutils format
 -out outfile        Output to filename rather than stdout
 -passin val         Input file pass phrase source
 -sign val           Sign digest using private key
 -verify val         Verify a signature using public key
 -prverify val       Verify a signature using private key
 -signature infile   File with signature to verify
 -keyform format     Key file format (PEM or ENGINE)
 -hex                Print as hex dump
 -binary             Print in binary form
 -d                  Print debug info
 -debug              Print debug info
 -fips-fingerprint   Compute HMAC with the key used in OpenSSL-FIPS fingerprint
 -hmac val           Create hashed MAC with key
 -mac val            Create MAC (not necessarily HMAC)
 -sigopt val         Signature parameter in n:v form
 -macopt val         MAC algorithm parameters in n:v form or key
 -*                  Any supported digest
 -rand val           Load the file(s) into the random number generator
 -writerand outfile  Write random data to the specified file
 -engine val         Use engine e, possibly a hardware device
 -engine_impl        Also use engine given by -engine for digest operations
```



### openssl help ecparam

```
Usage: ecparam [options]
Valid options are:
 -help               Display this summary
 -inform PEM|DER     Input format - default PEM (DER or PEM)
 -outform PEM|DER    Output format - default PEM
 -in infile          Input file  - default stdin
 -out outfile        Output file - default stdout
 -text               Print the ec parameters in text form
 -C                  Print a 'C' function creating the parameters
 -check              Validate the ec parameters
 -list_curves        Prints a list of all curve 'short names'
 -no_seed            If 'explicit' parameters are chosen do not use the seed
 -noout              Do not print the ec parameter
 -name val           Use the ec parameters with specified 'short name'
 -conv_form val      Specifies the point conversion form
 -param_enc val      Specifies the way the ec parameters are encoded
 -genkey             Generate ec key
 -rand val           Load the file(s) into the random number generator
 -writerand outfile  Write random data to the specified file
 -engine val         Use engine, possibly a hardware device
```


### openssl help ec

```
Usage: ec [options]
Valid options are:
 -help             Display this summary
 -in val           Input file
 -inform format    Input format - DER or PEM
 -out outfile      Output file
 -outform PEM|DER  Output format - DER or PEM
 -noout            Don't print key out
 -text             Print the key
 -param_out        Print the elliptic curve parameters
 -pubin            Expect a public key in input file
 -pubout           Output public key, not private
 -no_public        exclude public key from private key
 -check            check key consistency
 -passin val       Input file pass phrase source
 -passout val      Output file pass phrase source
 -param_enc val    Specifies the way the ec parameters are encoded
 -conv_form val    Specifies the point conversion form
 -*                Any supported cipher
 -engine val       Use engine, possibly a hardware device
```



### openssl help base64

```
Usage: base64 [options]
Valid options are:
 -help               Display this summary
 -list               List ciphers
 -ciphers            Alias for -list
 -in infile          Input file
 -out outfile        Output file
 -pass val           Passphrase source
 -e                  Encrypt
 -d                  Decrypt
 -p                  Print the iv/key
 -P                  Print the iv/key and exit
 -v                  Verbose output
 -nopad              Disable standard block padding
 -salt               Use salt in the KDF (default)
 -nosalt             Do not use salt in the KDF
 -debug              Print debug info
 -a                  Base64 encode/decode, depending on encryption flag
 -base64             Same as option -a
 -A                  Used with -[base64|a] to specify base64 buffer as a single line
 -bufsize val        Buffer size
 -k val              Passphrase
 -kfile infile       Read passphrase from file
 -K val              Raw key, in hex
 -S val              Salt, in hex
 -iv val             IV in hex
 -md val             Use specified digest to create a key from the passphrase
 -iter +int          Specify the iteration count and force use of PBKDF2
 -pbkdf2             Use password-based key derivation function 2
 -none               Don't encrypt
 -*                  Any supported cipher
 -rand val           Load the file(s) into the random number generator
 -writerand outfile  Write random data to the specified file
 -z                  Use zlib as the 'encryption'
 -engine val         Use engine, possibly a hardware device
```


### Examples

generate keys:

```
openssl ecparam -name secp256k1 -genkey -out privateKey.pem
openssl ec -in privateKey.pem -pubout -out publicKey.pem
```

Create a message.txt file and sign it:

```
openssl dgst -sha256 -sign privateKey.pem -out signatureDer.txt message.txt
```

Verify:

```
openssl dgst -sha256 -verify publicKey.pem -signature signatureDer.txt message.txt
```

Convert signature to base64:

```
openssl base64 -in signatureDer.txt -out signatureBase64.txt
```









