# Ethname - Free Crowd-Sourced "Off-Chain" Eth(erum) Name Service

ethname - light-weight crowd-sourced "off-chain" ethereum name to (contract) address service / helper (incl. punks v1,v2,v3,v4; phunks v1,v2, synth punks, punk blocks, etc.)  - yes, you can! - add more names / contracts via git ;-)


* home  :: [github.com/rubycocos/blockchain](https://github.com/rubycocos/blockchain)
* bugs  :: [github.com/rubycocos/blockchain/issues](https://github.com/rubycocos/blockchain/issues)
* gem   :: [rubygems.org/gems/ethname](https://rubygems.org/gems/ethname)
* rdoc  :: [rubydoc.info/gems/ethname](http://rubydoc.info/gems/ethname)




## Usage


Lookup (contract) addresses by name via the `Ethname` helper:

``` ruby
require 'ethname'

## let's try some punk (pixel art collection) contracts / services:
Ethname['punks v1']     #=> "0x6ba6f2207e343923ba692e5cae646fb0f566db8d"
Ethname['punks v2']     #=> "0xb47e3cd837ddf8e4c57f05d70ab865de6e193bbb"
Ethname['punks v3']     #=> "0xd33c078c2486b7be0f7b4dda9b14f35163b949e0"
Ethname['punks v4']     #=> "0xd12882c8b5d1bccca57c994c6af7d96355590dbd"

Ethname['punks v1 wrapped i']  #=> "0xf4a4644e818c2843ba0aabea93af6c80b5984114"
Ethname['punks v1 wrapped ii'] #=> "0x282bdd42f4eb70e7a9d9f40c8fea0825b7f68c5d"

Ethname['phunks v1']   #=> "0xa82f3a61f002f83eba7d184c50bb2a8b359ca1ce"
Ethname['phunks v2']   #=> "0xf07468ead8cf26c752c676e43c814fee9c8cf402"
Ethname['phunks v3']   #=> "0xa19f0378a6f3f3361d8e962f3589ec28f4f8f159"

Ethname['synth punks']  #=> "0xaf9ce4b327a3b690abea6f78eccbfefffbea9fdf"

Ethname['punks data']   #=> "0x16f5a35647d6f03d5d3da7b35409d65ba03af3b2"
Ethname['punk blocks']  #=> "0x58e90596c2065befd3060767736c829c18f3474c"

# and so on
```

Note: The names internally get "normalized", that is,
all characters except a-z and the digits 0-9 get stripped
that includes spaces, dots (.), dashes (-), underline (_), and so on.
Yes, for the lookup you can use all variants of uppercase (PUNKS)
or lowercase (punks) spellings. Example:


``` ruby
Ethname['Synth Punks']   #=> "0xaf9ce4b327a3b690abea6f78eccbfefffbea9fdf"
Ethname['SynthPunks']    #=> "0xaf9ce4b327a3b690abea6f78eccbfefffbea9fdf"
Ethname['Synthpunks']    #=> "0xaf9ce4b327a3b690abea6f78eccbfefffbea9fdf"
Ethname['SYNTH PUNKS']   #=> "0xaf9ce4b327a3b690abea6f78eccbfefffbea9fdf"
Ethname['SYNTHPUNKS']    #=> "0xaf9ce4b327a3b690abea6f78eccbfefffbea9fdf"
# and so on
```



## Inside the Crowd-Sourced "Off-Chain" Ethereum Name To (Contract) Address Service

The name to address mappings are fow now stored
in datafiles in the comma-separated value (.csv) format
and split by year (e.g. 2017, 2018, ..., 2021, 2022, 2023, etc.)

Example - [config/contracts.2017.csv](config/contracts.2017.csv):

``` csv
address, names
0x6Ba6f2207e343923BA692e5Cae646Fb0F566DB8D,  punks v1 | crypto punks v1
0xb47e3cd837ddf8e4c57f05d70ab865de6e193bbb,  punks v2 | crypto punks v2 | crypto punks market
0x60cd862c9c687a9de49aecdc3a99b74a4fc54ab6,  mooncats | mooncatrescue
...
```

Example - [config/contracts.2022.csv](config/contracts.2022.csv):

``` csv
address, names
0x282bdd42f4eb70e7a9d9f40c8fea0825b7f68c5d, punks v1 wrapped ii
0xD33c078C2486B7Be0F7B4DDa9B14F35163B949e0, punks v3
0xd12882c8b5d1bccca57c994c6af7d96355590dbd, punks v4
0xA19f0378A6F3f3361d8e962F3589Ec28f4f8F159,  phunks v3
0xaf9CE4B327A3b690ABEA6F78eCCBfeFFfbEa9FDf, synthetic punks | synth punks
0x58E90596C2065BEfD3060767736C829C18F3474c, punk blocks
0x23581767a106ae21c074b2276D25e5C3e136a68b,  moonbirds
...
```

###  Yes, You Can! - Add More Names / Contracts Via Git ;-)

Your contributions welcome. You are welcome to join in and
help to add more name to ethereum contract / service mappings.




## License

The scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.


## Questions? Comments?


Post them on the [D.I.Y. Punk (Pixel) Art reddit](https://old.reddit.com/r/DIYPunkArt). Thanks.


