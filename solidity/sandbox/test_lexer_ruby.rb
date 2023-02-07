###
#  test ruby built-in lexers
#   answer questions
#    does end-of-line comment include newline in lexeme - yes/no?
#
#  -  [[6, 21], :on_comment, "## a comment here\n", END],



require 'ripper'
require 'pp'

code = <<STR


5.times    do    |    x    |
	puts x
  puts "hello"
  puts 'hello'       ## a comment here
  ## another comment here
  ## another here

  ## yet another here
end


STR


puts code
pp Ripper.lex(code)


puts code
## unknown keyword: :keep_tokens
## note: requires ruby 3.2+ or such - double check!!!!
pp RubyVM::AbstractSyntaxTree.parse( code,
                                     keep_tokens: true).tokens

# =>
# [[0, :tIDENTIFIER, "puts", [1, 0, 1, 4]],
#  [1, :"(", "(", [1, 4, 1, 5]],
#  [2, :tSTRING_BEG, "'", [1, 5, 1, 6]],
#  [3, :tSTRING_CONTENT, "test", [1, 6, 1, 10]],
#  [4, :tSTRING_END, "'", [1, 10, 1, 11]],
#  [5, :",", ",", [1, 11, 1, 12]],
#  [6, :tSP, " ", [1, 12, 1, 13]],
#  [7, :")", ")", [1, 13, 1, 14]]]


__END__

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
 [[5, 0], :on_sp, "  ", BEG],
 [[5, 2], :on_ident, "puts", CMDARG],
 [[5, 6], :on_sp, " ", CMDARG],
 [[5, 7], :on_tstring_beg, "\"", CMDARG],
 [[5, 8], :on_tstring_content, "hello", CMDARG],
 [[5, 13], :on_tstring_end, "\"", END],
 [[5, 14], :on_nl, "\n", BEG],
 [[6, 0], :on_sp, "  ", BEG],
 [[6, 2], :on_ident, "puts", CMDARG],
 [[6, 6], :on_sp, " ", CMDARG],
 [[6, 7], :on_tstring_beg, "'", CMDARG],
 [[6, 8], :on_tstring_content, "hello", CMDARG],
 [[6, 13], :on_tstring_end, "'", END],
 [[6, 14], :on_sp, "       ", END],
 [[6, 21], :on_comment, "## a comment here\n", END],
 [[7, 0], :on_kw, "end", END],
 [[7, 3], :on_nl, "\n", BEG],
 [[8, 0], :on_ignored_nl, "\n", BEG],
 [[9, 0], :on_ignored_nl, "\n", BEG]]