module Solidity

class Parser

   def self.read( path )
      txt = read_text( path )
      new( txt )
   end



   def initialize( txt )
     @txt = txt
   end


  ###############
  ## quotes
  ##
  ## note: regex pattern \\ needs to get escaped twice, thus, \\.
  ##  and for literal \\ use \\\\\.

  ## => \\\\.    --  allow backslash escapes e.g. \n \t \\ etc.
  ## => [^`]     --  everything except backquote

  ## todo/fix - check if [^`] includes/matches newline too (yes)? -- add \n for multi-line!


  ## from the solidity grammar
  ##
  ## StringLiteralFragment
  ##  : 'unicode'? '"' DoubleQuotedStringCharacter* '"'
  ##  | 'unicode'? '\'' SingleQuotedStringCharacter* '\'' ;
  ##
  ## fragment
  ## DoubleQuotedStringCharacter
  ##   : ~["\r\n\\] | ('\\' .) ;
  ##
  ## fragment
  ## SingleQuotedStringCharacter
  ##   : ~['\r\n\\] | ('\\' .) ;


  SINGLE_QUOTE       = %r{'
                           ( \\\\. | [^'] )*
                         '}x

  DOUBLE_QUOTE       = %r{"
                           ( \\\\. | [^"] )*
                          "}x


  ## from the solidity grammar
  ##  > An identifier in solidity has to start with a letter,
  ##  >  a dollar-sign or an underscore and
  ##  >  may additionally contain numbers after the first symbol.
  ##
  ## Identifier
  ##   : IdentifierStart IdentifierPart* ;
  ##
  ##  fragment
  ##    IdentifierStart
  ##    : [a-zA-Z$_] ;
  ##
  ##  fragment
  ##    IdentifierPart
  ##   : [a-zA-Z0-9$_] ;

   NAME                    = /[a-zA-Z$_][a-zA-Z0-9$_]*/


   END_OF_LINE             = /\n|$/
   ## inline comments (multi- or end-of-line)
   END_OF_LINE_OR_COMMENT_OR_KEYWORD_OR_QUOTE  = / \n
                                         | $
                                         | (?=['"])
                                         | (?=\/(\/|\*))
                                         | (?=\bpragma\b)
                                         | (?=\bcontract\b)
                                         | (?=\babstract\b)
                                         | (?=\blibrary\b)
                                         | (?=\binterface\b)
                                       /x


  ## from the solidity grammar
  ##
  ## COMMENT
  ##   : '/*' .*? '*/'  ;
  ##
  ## LINE_COMMENT
  ##   : '//' ~[\r\n]* ;



   def _norm_whitespace( str )
      ## change newlines to spaces and
      ##   all multiple spaces to one
      str = str.gsub( /[ \t\n\r]+/, ' ' )
      str.strip
   end

   def _quick_pass_one
     ## note:  CANNOT handle inline comments
     ##           in pragma, contract, etc.  (get "silently" slurped)
     ##         report a parse error - if comments slurped - why? why not?
     ##


     tree = []

     s = StringScanner.new( @txt )

     loop do
       s.skip( /[ \t]+/ )  ## note: do NOT skip newlines here; pass along blank/empty lines for now - why? why not?
       if s.check( "'" )   ## single-quoted string
          str = s.scan( SINGLE_QUOTE )
          tree << [:string, str]
       elsif s.check( '"' )  ## double-quoted string
          str = s.scan( DOUBLE_QUOTE )
          tree << [:string, str]
       elsif s.check( '/*' )
          comment = s.scan_until( /\*\// )
          ## print "multi-line comment:"
          ## pp comment
          tree << [:comment, comment]
       elsif s.check( '//' )
          comment = s.scan_until( END_OF_LINE ).rstrip
          ## print "comment:"
          ## pp comment
          tree << [:comment, comment]
       else
          name = s.check( NAME )
          case name
          when 'pragma'
             code = s.scan_until( /;/ )
             code = _norm_whitespace( code )
             ## print "pragma:"
             ## pp code
             tree << [:pragma, code]
          when 'contract'
             code = s.scan_until( /(?=\{)/ )
             code = _norm_whitespace( code )
             ## print "contract:"
             ## pp code
             tree << [:contract, code]
          when 'abstract'
            code = s.scan_until( /(?=\{)/ )
            code = _norm_whitespace( code )
            ## print "abstract contract:"
            ## pp code
            tree << [:abstract_contract, code]
          when 'library'
            code = s.scan_until( /(?=\{)/ )
            code = _norm_whitespace( code )
            ## print "library:"
            ## pp code
            tree << [:library, code]
          when 'interface'
            code = s.scan_until( /(?=\{)/ )
            code = _norm_whitespace( code )
            ## print "interface:"
            ## pp code
            tree << [:interface, code]
          else
            ## slurp chunk ,that is, until newline or comment or tracked keyword
            chunk = s.scan_until( END_OF_LINE_OR_COMMENT_OR_KEYWORD_OR_QUOTE ).rstrip
            ## puts "chunk: >#{chunk.inspect}<"
            tree << chunk
          end
       end
       break if s.eos?
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
