

module Base58
class Bitcoin < Base

ALPHABET = %w[ 1 2 3 4 5 6 7 8 9
               A B C D E F G H   J K L M N   P Q R S T U V W X Y Z
               a b c d e f g h i j k   m n o p q r s t u v w x y z ]


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
  'A' => 9,
  'B' => 10,
  'C' => 11,
  'D' => 12,
  'E' => 13,
  'F' => 14,
  'G' => 15,
  'H' => 16,
  'J' => 17,
  'K' => 18,
  'L' => 19,
  'M' => 20,
  'N' => 21,
  'P' => 22,
  'Q' => 23,
  'R' => 24,
  'S' => 25,
  'T' => 26,
  'U' => 27,
  'V' => 28,
  'W' => 29,
  'X' => 30,
  'Y' => 31,
  'Z' => 32,
  'a' => 33,
  'b' => 34,
  'c' => 35,
  'd' => 36,
  'e' => 37,
  'f' => 38,
  'g' => 39,
  'h' => 40,
  'i' => 41,
  'j' => 42,
  'k' => 43,
  'm' => 44,
  'n' => 45,
  'o' => 46,   ## '0' => 46, 'O' => 46,
  'p' => 47,
  'q' => 48,
  'r' => 49,
  's' => 50,
  't' => 51,
  'u' => 52,
  'v' => 53,
  'w' => 54,
  'x' => 55,
  'y' => 56,
  'z' => 57,
}

def self.number() NUMBER; end        ## add num alias - why? why not?

## add shortcuts (convenience) aliases
NUM = NUMBER

end # class Bitcoin
end # module Base58
