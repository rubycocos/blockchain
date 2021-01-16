# encoding: utf-8

#####################
# Base32 Encoding - Crockford (by Douglas Crockford)
#    see https://www.crockford.com/wrmg/base32.html


module Base32
class Crockford < Base

ALPHABET = %w[ 0 1 2 3 4 5 6 7
               8 9 a b c d e f
               g h j k m n p q
               r s t v w x y z ]

def self.alphabet() ALPHABET; end



NUMBER = {
  '0' => 0, 'o' => 0, 'O'=> 0,
  '1' => 1, 'l' => 1, 'L'=> 1, 'i'=> 1, 'I' => 1,
  '2' => 2,
  '3' => 3,
  '4' => 4,
  '5' => 5,
  '6' => 6,
  '7' => 7,
  '8' => 8,
  '9' => 9,
  'a' => 10, 'A' => 10,
  'b' => 11, 'B' => 11,
  'c' => 12, 'C' => 12,
  'd' => 13, 'D' => 13,
  'e' => 14, 'E' => 14,
  'f' => 15, 'F' => 15,
  'g' => 16, 'G' => 16,
  'h' => 17, 'H' => 17,
  'j' => 18, 'J' => 18,
  'k' => 19, 'K' => 19,
  'm' => 20, 'M' => 20,
  'n' => 21, 'N' => 21,
  'p' => 22, 'P' => 22,
  'q' => 23, 'Q' => 23,
  'r' => 24, 'R' => 24,
  's' => 25, 'S' => 25,
  't' => 26, 'T' => 26,
  'v' => 27, 'V' => 27,
  'w' => 28, 'W' => 28,
  'x' => 29, 'X' => 29,
  'y' => 30, 'Y' => 30,
  'z' => 31, 'Z' => 31
}
def self.number() NUMBER; end


## simple hash map (helper) for conversion to binary string
BINARY = _build_binary()
CODE   = _build_code()

## add shortcuts (convenience) aliases
BIN = BINARY
NUM = NUMBER

def self.code() CODE; end
def self.binary() BINARY; end

end # class Crockford
end # module Base32
