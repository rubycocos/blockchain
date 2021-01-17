

module Base58
class Flickr < Base

ALPHABET = %w[ 1 2 3 4 5 6 7 8 9
               a b c d e f g h i j k   m n o p q r s t u v w x y z
               A B C D E F G H   J K L M N   P Q R S T U V W X Y Z ]


def self.alphabet() ALPHABET; end    ## add alpha / char aliases - why? why not?

## Note:
##   for decoding allow (misspelled) l/I for 1  - why? why not?
##    and               (misspelled) 0/O for o  - why? why not?


NUMBER = {
  '1' => 0,   ## 'l' => 0, 'I' => 0,
  '2' => 1,
  '3' => 2,
  '4' => 3,
  '5' => 4,
  '6' => 5,
  '7' => 6,
  '8' => 7,
  '9' => 8,
  'a' => 9,
  'b' => 10,
  'c' => 11,
  'd' => 12,
  'e' => 13,
  'f' => 14,
  'g' => 15,
  'h' => 16,
  'i' => 17,
  'j' => 18,
  'k' => 19,
  'm' => 20,
  'n' => 21,
  'o' => 22,   ## '0' => 22, 'O' => 22,
  'p' => 23,
  'q' => 24,
  'r' => 25,
  's' => 26,
  't' => 27,
  'u' => 28,
  'v' => 29,
  'w' => 30,
  'x' => 31,
  'y' => 32,
  'z' => 33,
  'A' => 34,
  'B' => 35,
  'C' => 36,
  'D' => 37,
  'E' => 38,
  'F' => 39,
  'G' => 40,
  'H' => 41,
  'J' => 42,
  'K' => 43,
  'L' => 44,
  'M' => 45,
  'N' => 46,
  'P' => 47,
  'Q' => 48,
  'R' => 49,
  'S' => 50,
  'T' => 51,
  'U' => 52,
  'V' => 53,
  'W' => 54,
  'X' => 55,
  'Y' => 56,
  'Z' => 57,
}

def self.number() NUMBER; end        ## add num alias - why? why not?

## add shortcuts (convenience) aliases
NUM = NUMBER

end # class Flickr
end # module Base58
