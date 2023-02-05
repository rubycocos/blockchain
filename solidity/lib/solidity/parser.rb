module Solidity

class Parser

   def self.read( path )
      txt = read_text( path )
      new( txt )
   end



   def initialize( txt )
     @txt = txt
   end





   def _quick_pass_one
     tree = []

     lex = Lexer.new( @txt )

     until lex.eos?
       while lex.peek == :sp do   ## note: do NOT skip newlines here; pass along blank/empty lines for now - why? why not?
           lex.next
       end

       case lex.peek
       when :comment  ## single or multi-line comment
           tree << [:comment, lex.next]
       when :pragma
            code = lex.scan_until( :';',
                                   include: true )
             ## print "pragma:"
             ## pp code
             tree << [:pragma, code]
       when :contract
             code = lex.scan_until( :'{' )
             ## print "contract:"
             ## pp code
             tree << [:contract, code]
       when :abstract
             code = lex.scan_until( :'{' )
             ## print "abstract contract:"
             ## pp code
             tree << [:abstract_contract, code]
       when :library
             code = lex.scan_until( :'{' )
             ## print "library:"
             ## pp code
             tree << [:library, code]
       when :interface
             code = lex.scan_until( :'{' )
             ## print "interface:"
             ## pp code
             tree << [:interface, code]
       else
            ## slurp chunk ,that is, until newline or comment or tracked keyword
            last = tree[-1]
            if last.is_a?( String )
               last <<  lex.next   ## append lexeme to last chunk
            else
               tree << lex.next    ## start a new chunk
            end
       end
     end

     tree
   end



   def outline
      buf = String.new( '' )
      tree = _quick_pass_one

      tree.each do |node|
         if node.is_a?( Array )
            case node[0]
            when :contract           then  buf << node[1] << "\n"
            when :abstract_contract  then  buf << node[1] << "\n"
            when :interface          then  buf << node[1] << "\n"
            when :library            then  buf << node[1] << "\n"
            else
            end
         end
      end

      buf
   end

   def pragmas
      buf = String.new( '' )
      tree = _quick_pass_one

      tree.each do |node|
         if node.is_a?( Array )
            case node[0]
            when :pragma             then  buf << node[1] << "\n"
            end
         end
      end

      buf
   end


end  # class Parser


end  # module Solidity
