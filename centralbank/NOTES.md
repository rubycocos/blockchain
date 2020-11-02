# Notes


## Todos

- [ ] add favicon.png  - why? why not? (see webservice gem)
- [ ] add a Pool class (for pending transaction pool) !!!!!
- [ ] add secure versions with signature e.g. SecureWallet, SecureTransaction, etc.

```
Source: https://www.reddit.com/r/ruby/comments/7ly337/day_24_ruby_advent_calendar_2017_centralbank/

I'm playing with your Ruby blockchain stuff. It's very good. It's giving me a way to learn it without having to learn Go or C++ at the same time. But...

When I try running central bank from the command line as described in blockchains section 6. using

centralbank
it doesn't work because centralbank is in the bin/ directory, so I tried (after setting chmod +x etc)

bin/centralbank
and then got an error I've never seen before

env: ruby\r: No such file or directory
So I wrote added one space at the end of the shebang header line That removed the extra \r and I then progressed to

bin/centralbank
Traceback (most recent call last):
     (LoadError)h file or directory --
Because it doesn't know where the library path is. If I run with

  ruby -Ilib bin/centralbank
Then it's fine.

So you need to do something to remove that \r at the end of the shebang line, and add the library path before the require.
```
