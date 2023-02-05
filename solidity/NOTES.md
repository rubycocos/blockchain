# Notes About Solidity




## More

**Solidity**
Docu:
- Grammar @ <https://docs.soliditylang.org/en/latest/grammar.html>

Source:
- Grammar (Parser) @ <https://github.com/ethereum/solidity/blob/develop/docs/grammar/SolidityParser.g4>
- Grammar (Lexer) @ <https://github.com/ethereum/solidity/blob/develop/docs/grammar/SolidityLexer.g4>




**SolGrep** - A scriptable semantic grep utility for solidity
- Source @ <https://github.com/tintinweb/solgrep>
- Package @ <https://www.npmjs.com/package/solgrep>


**Solidity Parser for JavaScript** - A Solidity parser for JS built on top of a robust ANTLR4 grammar
- Source @ <https://github.com/solidity-parser/parser>
- Package @ <https://www.npmjs.com/package/@solidity-parser/parser>



**Solidity Language Grammar** -
The ANTLR (ANother Tool for Language Recognition) grammar for Solidity
- Source @ <https://github.com/solidity-parser/antlr>
- Grammar @ <https://github.com/solidity-parser/antlr/blob/master/Solidity.g4>



## Lexer Notes

 example on lexer  with stringscanner
   see <https://blog.appsignal.com/2019/07/02/ruby-magic-brewing-our-own-template-lexer-in-ruby.html>



https://github.com/veox/pygments-lexer-solidity/blob/mistress/pygments_lexer_solidity/lexer.py
https://github.com/veox/pygments-lexer-solidity/blob/mistress/example.sol
https://github.com/veox/pygments-lexer-solidity/blob/mistress/example.yul


https://github.com/frangio/solidity-lexer
https://github.com/frangio/solidity-lexer/blob/master/regex/normal

https://github.com/frangio/solidity-comments

https://pygments.org/docs/lexers/



RubyVM::AbstractSyntaxTree.parse("puts('test', )", keep_tokens: true).tokens
# =>
# [[0, :tIDENTIFIER, "puts", [1, 0, 1, 4]],
#  [1, :"(", "(", [1, 4, 1, 5]],
#  [2, :tSTRING_BEG, "'", [1, 5, 1, 6]],
#  [3, :tSTRING_CONTENT, "test", [1, 6, 1, 10]],
#  [4, :tSTRING_END, "'", [1, 10, 1, 11]],
#  [5, :",", ",", [1, 11, 1, 12]],
#  [6, :tSP, " ", [1, 12, 1, 13]],
#  [7, :")", ")", [1, 13, 1, 14]]]


require 'ripper'
require 'pp'

code = <<STR


5.times    do    |    x    |
	puts x
  puts "hello"
  puts 'hello'       ## a comment here
end


STR

puts code
pp Ripper.lex(code)



[[[1, 0], :on_ignored_nl, "\n", BEG],
 [[2, 0], :on_ignored_nl, "\n", BEG],
 [[3, 0], :on_int, "5", END],
 [[3, 1], :on_period, ".", DOT],
 [[3, 2], :on_ident, "times", ARG],
 [[3, 7], :on_sp, "    ", ARG],
 [[3, 11], :on_kw, "do", BEG],
 [[3, 13], :on_sp, "    ", BEG],
 [[3, 17], :on_op, "|", BEG|LABEL],
 [[3, 18], :on_sp, "    ", BEG|LABEL],
 [[3, 22], :on_ident, "x", ARG],
 [[3, 23], :on_sp, "    ", ARG],
 [[3, 27], :on_op, "|", BEG|LABEL],
 [[3, 28], :on_ignored_nl, "\n", BEG|LABEL],
 [[4, 0], :on_sp, "\t", BEG|LABEL],
 [[4, 1], :on_ident, "puts", CMDARG],
 [[4, 5], :on_sp, " ", CMDARG],
 [[4, 6], :on_ident, "x", END|LABEL],
 [[4, 7], :on_nl, "\n", BEG],
 [[5, 0], :on_kw, "end", END],
 [[5, 3], :on_nl, "\n", BEG],
 [[6, 0], :on_ignored_nl, "\n", BEG],
 [[7, 0], :on_ignored_nl, "\n", BEG]]