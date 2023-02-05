module Solidity

class Lexer

   def self.read( path )
      txt = read_text( path )
      new( txt )
   end



   def initialize( txt )
     @txt    = txt
     @tokens = tokenize
     @pos    = 0
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

   NAME  = /[a-zA-Z$_][a-zA-Z0-9$_]*/


  ## from the solidity grammar
  ##
  ## COMMENT
  ##   : '/*' .*? '*/'  ;
  ##
  ## LINE_COMMENT
  ##   : '//' ~[\r\n]* ;


   def tokenize
     t = []
     s = StringScanner.new( @txt )

     until s.eos?   ## loop until hitting end-of-string (file)
       if s.check( /[ \t]*\/\*/ )
          ## note: auto-slurp leading (optinal) spaces!!!! - why? why not?
          comment = s.scan_until( /\*\// )
          ## print "multi-line comment:"
          ## pp comment
          t << [:comment, comment.lstrip]
       elsif s.check( /[ \t]*\/\// )
          ## note: auto-slurp leading (optinal) spaces!!!!  - why? why not?
          ## note: auto-remove newline AND trailing whitespace - why? why not?
          comment = s.scan_until( /\n|$/ ).strip
          ## print "comment:"
          ## pp comment
          t << [:comment, comment]
       elsif s.scan( /[ \t]+/ )   ## one or more spaces
          ## note: (auto-)convert tab to space - why? why not?
          t << [:sp, s.matched.gsub( /[\t]/, ' ') ]
       elsif s.scan( /\r?\n/ )    ## check for (windows) carriage return (\r) - why? why not?
          t << [:nl, "\n" ]
       elsif s.check( "'" )   ## single-quoted string
          str = s.scan( SINGLE_QUOTE )
          t << [:string, str]
       elsif s.check( '"' )  ## double-quoted string
          str = s.scan( DOUBLE_QUOTE )
          t << [:string, str]
       elsif s.scan( NAME )
          name = s.matched
          case name
          when 'pragma'    then  t << [:pragma, name]
          when 'contract'  then  t << [:contract, name]
          when 'abstract'  then  t << [:abstract, name]
          when 'library'   then  t << [:library, name]
          when 'interface' then  t << [:interface, name]
          when 'function'  then  t << [:function, name]
          when 'struct'    then  t << [:struct, name]
          when 'enum'      then  t << [:enum, name]
          when 'event'     then  t << [:event, name]
          else
             t << [:ident, name]
          end
       elsif s.scan( /;/ )   then   t << [:';', ';']
       elsif s.scan( /\{/ )  then   t << [:'{', '{']
       elsif s.scan( /\}/ )  then   t << [:'}', '}']
       else    ## slurp until hitting a "tracked" token again
           last = t[-1]
           if last.is_a?( String )
              last << s.getch  ## append char to last chunk
           else
              t << s.getch     ## start a new chunk
           end
       end
     end
     t
   end



   def reset() @pos = 0; end
   def pos()   @pos;  end
   def peek
      ## note: returns token type for now (e.g. :string, :sp, etc.)
      ##              and NOT token struct for now - why? why not?
      t = @tokens[@pos]
      t.nil? || t.is_a?( String ) ? t : t[0]
   end
   def next
      ## note: returns type lexeme (string content) for now
      ##            and NOT token struct for now - why? why not?
      t = @tokens[@pos]
      str =  t.nil? || t.is_a?( String ) ? t : t[1]
      @pos += 1      unless t.nil?
      str
   end
   def eos?()  peek().nil?; end




   #################################################
   #  "higher-level" helpers
   def scan_until( tt, include: false )
      code = String.new('')
      while (peek=self.peek) != tt do
         ## note:  turn inline comments into a single space
         code <<   if peek == :comment
                       self.next   ## note: next (w/o self) is parsed as keyword
                       ' '
                   else
                       self.next  ## note: next (w/o self) is parsed as keyword
                   end
      end
      code << self.next       if include  ## include ';' too - why? why not?
      code = _norm_whitespace( code )
      code
   end

   def _norm_whitespace( str )
      ## change newlines to spaces and
      ##   all multiple spaces to one
      str = str.gsub( /[ \t\n\r]+/, ' ' )
      str.strip
   end



end  # class Lexer
end  # module Solidity
