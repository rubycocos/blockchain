> Someday, owning a CryptoPunk might signify just how early of an
> adopter you were into the world of blockchain and its thriving digital
> art scene. Or, they could just be a bunch of [24×24 pixel] images.
>
> -- [June 2017](https://mashable.com/2017/06/16/cryptopunks-ethereum-art-collectibles/)
>
>
> There will be a desire and need to buy expensive [status symbols]
> in the digital realm [to "flex" how rich and stupid I am].
> What could be more desirable than a small [24×24]
> pixelated [knitted cap-wearing ape] face?
> CryptoPunk artwork [![](i/punk-8219.png) [#8219](https://www.larvalabs.com/cryptopunks/details/8219)] just sold for $176,000.
>
> -- [January 2021](https://decrypt.co/53519/an-ethereum-based-cryptopunk-artwork-just-sold-for-176000)
>
>
> Ultra-rare alien [24×24 pixel] CryptoPunk
> sells for 605 ETH, or $750,000.
> The investment thesis. "Aliens are the rarest form of CryptoPunk and
> we believe that the acquired Alien [![](i/punk-2890.png) [#2890](https://www.larvalabs.com/cryptopunks/details/2890), one of nine]
> will be prized by collectors over
> time and mature into an iconic digital art piece."
>
> -- [January 2021](https://cointelegraph.com/news/ultra-rare-alien-cryptopunk-nft-sells-for-605-eth-or-750-000)
>
>
> The [CryptoPunksMarket] contract now holds 4,095 ETH (~$5.4M USD) in open bids and pending withdrawals.
>
> -- [January 2021](https://twitter.com/larvalabs/status/1353915659453870080)



# Crypto Punks

cryptopunks - mint your own 24×24 pixel punk images off chain from the True Official Genuine CryptoPunks™ sha256-verified original 10 000 unique character collection; incl. 2x/4x/8x zoom for bigger sizes

* home  :: [github.com/rubycoco/blockchain](https://github.com/rubycoco/blockchain)
* bugs  :: [github.com/rubycoco/blockchain/issues](https://github.com/rubycoco/blockchain/issues)
* gem   :: [rubygems.org/gems/cryptopunks](https://rubygems.org/gems/cryptopunks)
* rdoc  :: [rubydoc.info/gems/cryptopunks](http://rubydoc.info/gems/cryptopunks)


New to Crypto Punks?
See the [**Awesome CryptoPunks Bubble (Anno 2021) - Modern 24×24 Pixel Crypto Art on the Blockchain** »](https://github.com/openblockchains/awesome-cryptopunks-bubble)


## Command Line

Use the `punk` (or `cryptopunk`) command line tool. Try:

```
$ punk -h
```

resulting in:

```
Usage: cryptopunk [options] IDs
  Mint punk characters from composite (./punks.png) - for IDs use 0 to 9999

  Options:
    -z, --zoom=ZOOM        Zoom factor x2, x4, x8, etc. (default: 1)
    -d, --dir=DIR          Output directory (default: .)
    -f, --file=FILE        True Official Genuine CryptoPunks™ composite image (default: ./punks.png)
    -h, --help             Prints this help
```


Step 0 -  Download the True Official Genuine CryptoPunks™ composite image

One time / first time only - Download the True Official Genuine CryptoPunks™ composite
housing all 10 000 CryptoPunks
in a single 2400×2400 image (~830 kb) for free.
See [`punks.png` »](https://github.com/larvalabs/cryptopunks/blob/master/punks.png)


![](i/punks-zoom.png)



Now let's give it a try.  Let's mint punk #0, #2890, and #8219:

```
$ punk 0 2890 8219
```

printing:

```
==> reading >./punks.png<...
     >ac39af4793119ee46bbff351d8cb6b5f23da60222126add4268e261199a2921b< SHA256 hash matching
         ✓ True Official Genuine CryptoPunks™ verified
==> (1/3) minting punk #0; writing to >./punk-0000.png<...
==> (2/3) minting punk #2890; writing to >./punk-2890.png<...
==> (3/3) minting punk #8219; writing to >./punk-8219.png<...
```

And voila!

![](i/punk-0000.png)
![](i/punk-2890.png)
![](i/punk-8219.png)



**Bonus:  Try the `-z/--zoom` factor x2, x4, x8, etc.**

Let's give it a try.  Let's mint punk #0, #2890, and #8219 in 2x format:

```
$ punk --zoom 2 0 2890 8219
# -or-
$ punk -z2 0 2890 8219
```

printing:

```
==> reading >./punks.png<...
     >ac39af4793119ee46bbff351d8cb6b5f23da60222126add4268e261199a2921b< SHA256 hash matching
         ✓ True Official Genuine CryptoPunks™ verified
    setting zoom to 2x
==> (1/3) minting punk #0; writing to >punk-0000x2.png<...
==> (2/3) minting punk #2890; writing to >punk-2890x2.png<...
==> (3/3) minting punk #8219; writing to >punk-8219x2.png<...
```

And voila!

![](i/punk-0000x2.png)
![](i/punk-2890x2.png)
![](i/punk-8219x2.png)

And x4:

![](i/punk-0000x4.png)
![](i/punk-2890x4.png)
![](i/punk-8219x4.png)


And x8:

![](i/punk-0000x8.png)
![](i/punk-2890x8.png)
![](i/punk-8219x8.png)


And so on.


## Usage in Your Scripts


Yes, you can mint punks in your own scripts.
Example:

``` ruby
require 'cryptopunks'

# step 1: read True Official Genuine CryptoPunks™ composite image
punks = Punks::Image.read( './punks.png' )

# step 2: start minting

punks[0].save( './punk-0000.png' )
punks[2890].save( './punk-2890.png' )
punks[8219].save( './punk-8219.png')

# or change the zoom factor
punks.zoom = 4   # use x4

punks[0].save( './punk-0000x4.png' )
punks[2890].save( './punk-2890x4.png' )
punks[8219].save( './punk-8219x4.png')
```

and so on. Happy miniting.
That's all for now.



## Install

Just install the gem:

    $ gem install cryptopunks


## License

The scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.


## Questions? Comments?

Send them along to the [wwwmake forum](http://groups.google.com/group/wwwmake).
Thanks!
