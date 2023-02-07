require 'cocos'
require 'optparse'



module ABIDump

  class Tool

    def self.main( args=ARGV )
      puts "==> welcome to abidump tool with args:"
      pp args

      options = {
                }

      parser = OptionParser.new do |opts|

        opts.on("-j", "--json", "use json format (default: false)") do |value|
          options[ :json]  = true
        end

        opts.on("-y", "--yaml", "use yaml format (default: false)") do |value|
            options[ :yaml]  = true
        end

        opts.on("-h", "--help", "Prints this help") do
          puts opts
          exit
        end
      end

      parser.parse!( args )
      puts "options:"
      pp options

      puts "args:"
      pp args

      if args.size < 1
        puts "!! ERROR - no abi contract path found - use  $ abidump <path>"
        puts ""
        exit
      end

      path = args[0]

      ## read data
      data = read_json( path )

      if options[ :yaml ]
         do_dump_yaml( data )
      elsif options[ :json ]
         do_dump_json( data )
      else
         do_dump( data )
      end

      puts "bye"
    end




    def self.do_dump_yaml( data )
      buf = YAML.dump( data )
      puts buf
    end

    def self.do_dump_json( data )
      buf = JSON.pretty_generate( data )
      puts buf
    end

    def self._dump_types( data, indent: 2 )
       ## hack:  remove items and re-add to sort key order!!!
       ##
       ## clean-up / normalize type
       ##   if type && internalType is the same
       ##      than delete internalType for now - why? why not?
       data.each do |h|
          name          = h.delete('name')
          type          = h.delete('type')
          internal_type = h.delete('internalType')
          indexed       = h.delete('indexed')
          components    = h.delete('components')

          unless h.empty?
            puts "!! ERROR - found unknown props in abi inputs/outpus:"
            pp h
            exit 1
          end

          print ' ' * indent
          print type
          print ' indexed'   if indexed  ## note: indexed is a true/false prop
          ## note: change empty name e.g. '' to _  - why? why not?
          if name
            print ' '
            print name.empty?  ? "_" : name
          end

          print " - #{internal_type}" if type && internal_type && type != internal_type
          print "\n"

          _dump_types( components, indent: indent+2 )  if components
       end
    end



    def self._dump( data, indent: 2 )
      buf = YAML.dump( data )
      buf = buf.sub( /^---\n?/, '' )   ## remove leading --- if present

      # puts "---> debug:"
      # pp buf
      # puts "<---"

      buf.each_line do |line|
        print ' ' * indent
        puts line
      end
    end


    def self.do_dump( data )

      ## calc summary stats
      counter = {}
      data.each do |h|
         type = h['type']
         stat = counter[ type ] ||= { count: 0, names: [] }
         stat[:count] += 1

         name = h['name']
         stat[:names] << name   if name
      end


       data.each do |h|
          type    = h.delete('type')
          name    = h.delete('name')
          inputs  = h.delete('inputs')
          outputs = h.delete('outputs')

          puts
          print "==> #{type}"
          print " #{name}"    if name
          puts ":"
          _dump( h, indent: 6 )

          if inputs
            print "    inputs (#{inputs.size})"
            if inputs.size > 0
              print ":\n"
              _dump_types( inputs, indent: 6 )
            else
              print "\n"
            end
          end

          if outputs
            print "    outputs (#{outputs.size})"
            if outputs.size > 0
              print ":\n"
              _dump_types( outputs, indent: 6 )
            else
              print "\n"
            end
          end
       end

     ## always dump stats at the end - why? why not?
     puts
     puts "==> summary: "
     puts "    #{data.size} abi item(s):"
     counter.each do |(type, h)|
        count = h[:count]
        print "      #{count}"
        print " #{type}"
        print "s" if count > 1
        print "\n"

        names = h[:names]
        if names.size > 0
           print "         "
           print names.join( ', ' )
           print "\n"
        end
     end
    end
  end # class Tool
end  # module ABIDump




##############
#  add alternate spellings - why? why not?
AbiDump = ABIDump
Abidump = ABIDump
