require 'cocos'


## our own code
require_relative 'solidity/version'    # note: let version always go first




module Solidity

class Parser

   def self.read( path )
      txt = read_text( path )
      new( txt )
   end



   def initialize( txt )
     @txt = txt
   end

   SINGLE_COMMENT_RX         = %r{^[ ]*//}
   MULTI_COMMENT_BEGIN_RX    = %r{^[ ]*/\*}
   MULTI_COMMENT_END_RX      = %r{\*/[ ]*$}

   ID = '[a-zA-Z][a-zA-Z0-9]*'

   PRAGMA_RX            = %r{^[ ]*pragma}
   LIBRARY_RX           = %r{^[ ]*library[ ]+(?<id>#{ID})[ \{]}
   ABSTRACT_CONTRACT_RX = %r{^[ ]*abstract[ ]+contract[ ]+(?<id>#{ID})[ \{]}
   CONTRACT_RX          = %r{^[ ]*contract[ ]+(?<id>#{ID})[ \{]}
   INTERFACE_RX         = %r{^[ ]*interface[ ]+(?<id>#{ID})[ \{]}


   def _quick_pass_one
     tree = []
     node = nil

     inside_comment = false

     @txt.each_line do |line|
         line = line.chomp ## remove trailing newline
         ## pp line

         if inside_comment
            node[1] << line
            if  MULTI_COMMENT_END_RX.match( line )
               tree << node
               inside_comment = false
            end
         else
           if SINGLE_COMMENT_RX.match( line )   #  end-of-line comments
               line = line.strip  ## remove leading & trailing spaces
               ## note: fold end-of-line comments into a block (if not separated by newline)
               node = tree[-1]
               if  node.is_a?( Array ) &&
                   node[0] == :comment && node[1][0].start_with?( '//' )
                  node[1] << line
               else
                 tree << [:comment, [line]]
               end
           elsif MULTI_COMMENT_BEGIN_RX.match( line )
              inside_comment = true
              node = [:comment, [line]]
           elsif PRAGMA_RX.match( line )
              line = line.strip
              tree << [:pragma, line]
           elsif LIBRARY_RX.match( line )
              line = line.strip
              tree << [:library, line]
           elsif ABSTRACT_CONTRACT_RX.match( line )
              line = line.strip
              tree << [:abstract_contract, line]
           elsif CONTRACT_RX.match( line )
              line = line.strip
              tree << [:contract, line]
           elsif INTERFACE_RX.match( line )
              line = line.strip
              tree << [:interface, line]
           else
              tree << line
           end
         end
     end # each_line

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



puts Solidity.banner    ## say hello
