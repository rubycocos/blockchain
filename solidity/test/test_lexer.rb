##
#  to run use
#     ruby -I ./lib -I ./test test/test_lexer.rb


require 'helper'



class TestLexer < MiniTest::Test

def _untokenize( tokens )
  buf = String.new('')
  tokens.each do |t|
    buf <<  (t.is_a?( String ) ? t : t[1])

    ## dump some token types
    pp t    if [:comment, :string].include?( t[0] )
  end
  buf
end


def test_contracts
    ['contract1',
     'contract2',
     'contract3'].each do |name, exp|
      path = "./contracts/#{name}.sol"
      lexer = Solidity::Lexer.read( path )

      tokens = lexer.tokenize

      txt = read_text( path )
      assert_equal txt, _untokenize( tokens )
    end
end
end   ## class TestLexer
