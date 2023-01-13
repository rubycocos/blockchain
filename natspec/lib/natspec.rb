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


    ## pre-process sections
    ##  remove trailing empty lines
    _strip_empty_leading_lines( head )
    _strip_empty_trailing_lines( head )
    _indent_code_block( head )

    sections.each do |heading, lines|
      _strip_empty_leading_lines( lines )
      _strip_empty_trailing_lines( lines )
      _strip_code_block( lines )
    end


    Document.new( head, sections )
  end


  def _strip_code_block( sect )
    sect.reject! { |line| line.start_with?( '```' ) }
  end

  def _indent_code_block( sect )
    ## step 1: indent code blocks
    inside_block = false
    sect.each_with_index do |line,i|
      if line.start_with?( '```' )
         inside_block = !inside_block
      elsif inside_block
          sect[i] = (' '*4) + sect[i]
      else
         ## regular line; keep going
      end
    end
    ## step 2: remove all code block lines
    _strip_code_block( sect )
  end


  def _strip_empty_trailing_lines( sect )
     loop do
       line = sect[-1]
         if line && line.empty?
            sect.pop
         else
            break
         end
     end
     sect
  end

  def _strip_empty_leading_lines( sect )
    loop do
      line = sect[0]
        if line && line.empty?
           sect.shift
        else
           break
        end
    end
    sect
 end
end  # class Parser


  def self.read( path )
    Parser.new( read_text( path ) ).parse
  end

end  # module Natspec
