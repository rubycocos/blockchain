require 'cocos'


module Natspec


class Document
   attr_reader :head, :sections,
               :storage, :functions
   def initialize( head, sections )
      @head      = head
      @sections = sections

      @storage, @functions = _parse_sections( @sections )
   end

   def _parse_sections( sections )

     storage = {}
     functions = {}

     sections.each do |heading, lines|

       if (m=heading.match(/\Astorage[ ]+(.+)[ ]+(?<id>[_A-Za-z0-9]+)\z/))
          storage[ m[:id] ] = [heading,lines]
       elsif (m=heading.match(/\Afunction[ ]+(?<id>[_A-Za-z0-9]+)([ (]|\z)/))
          functions[ m[:id] ] = [heading,lines]
       else
         puts "!! ERROR - unsupported heading type in line >#{heading}<; sorry"
         exit 1
       end
     end

     [storage, functions]
   end
end


class Parser
  def initialize( txt )
    @txt = txt
  end

  def parse
    head = []
    sections = []

    section = nil
    @txt.each_line do |line|

      line = line.rstrip
      if (m=line.match( /\A[ ]*\#{2}[ ]*(?<heading>.+)[ ]*\z/ ))
        puts "  found heading >#{m[:heading]}<"
        sections << section   if section
        section = [m[:heading],[]]
      elsif (m=line.match(/\A[ ]*\#{1,}/ ))
        puts "   !! ERROR - unsupported heading level in line >#{line}<; sorry"
        exit 1
      else
          if section
            section[1] << line
          else
            head << line
          end
      end
    end

    sections <<  section  if section

    Document.new( head, sections )
  end
end  # class Parser

  def self.read( path )
    Parser.new( read_text( path ) ).parse
  end

end  # module Natspec
