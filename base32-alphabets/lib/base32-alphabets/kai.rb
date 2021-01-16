# encoding: utf-8

#####################
# why kai?
#  in honor of Kaigani who deciphered the genes - thanks!
#    see https://medium.com/@kaigani/the-cryptokitties-genome-project-on-dominance-inheritance-and-mutation-b73059dcd0a4


module Base32
class Kai < Base

# See https://en.wikipedia.org/wiki/Base58
## Note: aplpabet used for encoding
ALPHABET = %w[ 1 2 3 4 5 6 7 8
               9 a b c d e f g
               h i j k m n o p
               q r s t u v w x ]

def self.alphabet() ALPHABET; end    ## add alpha / char aliases - why? why not?



## Note:
##   for decoding allow (misspelled) l/L for 1
##    and               (misspelled)  0  for o/O - why? why not?
##    and UPPERCASE letters - why? why not?

NUMBER = {
  '1' => 0, 'l' => 0, 'L'=> 0,
  '2' => 1,
  '3' => 2,
  '4' => 3,
  '5' => 4,
  '6' => 5,
  '7' => 6,
  '8' => 7,
  '9' => 8,
  'a' => 9,  'A' => 9,
  'b' => 10, 'B' => 10,
  'c' => 11, 'C' => 11,
  'd' => 12, 'D' => 12,
  'e' => 13, 'E' => 13,
  'f' => 14, 'F' => 14,
  'g' => 15, 'G' => 15,
  'h' => 16, 'H' => 16,
  'i' => 17, 'I' => 17,
  'j' => 18, 'J' => 18,
  'k' => 19, 'K' => 19,
  'm' => 20, 'M' => 20,
  'n' => 21, 'N' => 21,
  'o' => 22, 'O' => 22, '0' => 22,
  'p' => 23, 'P' => 23,
  'q' => 24, 'Q' => 24,
  'r' => 25, 'R' => 25,
  's' => 26, 'S' => 26,
  't' => 27, 'T' => 27,
  'u' => 28, 'U' => 28,
  'v' => 29, 'V' => 29,
  'w' => 30, 'W' => 30,
  'x' => 31, 'X' => 31
}

def self.number() NUMBER; end        ## add num alias - why? why not?


## simple hash map (helper) for conversion to binary string
BINARY = _build_binary()
CODE   = _build_code()

## add shortcuts (convenience) aliases
BIN = BINARY
NUM = NUMBER

def self.code() CODE; end
def self.binary() BINARY; end        ## add bin alias - why? why not?

end # class Kai
end # module Base32
