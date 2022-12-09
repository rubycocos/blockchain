
module Ethlite


    ## todo/check   - use encoding -ascii-8bit for source file or ? - why? why not?
    ## use  #b/.b  to ensure binary encoding? - why? why not?

    ## todo/check:  use auto-freeze string literals magic comment - why? why not?
    BYTE_EMPTY = "".b.freeze
    BYTE_ZERO  = "\x00".b.freeze
    BYTE_ONE   = "\x01".b.freeze


    TT32   = 2**32
    TT40   = 2**40
    TT160  = 2**160
    TT256  = 2**256
    TT64M1 = 2**64 - 1

    UINT_MAX = 2**256 - 1
    UINT_MIN = 0
    INT_MAX  = 2**255 - 1
    INT_MIN  = -2**255

    HASH_ZERO = ("\x00"*32).b.freeze


    PUBKEY_ZERO = ("\x00"*32).b.freeze
    PRIVKEY_ZERO = ("\x00"*32).b.freeze

    PRIVKEY_ZERO_HEX = ('0'*64).freeze

    CONTRACT_CODE_SIZE_LIMIT = 0x6000

end  # module Ethlite
