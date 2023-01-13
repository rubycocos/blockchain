require 'abiparser'
require 'natspec'


## our own code
## require_relative 'abidoc/version'    # note: let version always go first



module ABI
  class Contract


def generate_code( name: 'Contract',
                   address: nil,
                   natspec: nil )
  buf = ''
  buf << "#########################\n"
  buf << "# #{name} contract / (blockchain) services / function calls\n"
  buf << "#  auto-generated via abigen (see https://rubygems.org/gems/abigen) on #{Time.now.utc}\n"
  buf << "#  - #{query_functions.size} query functions(s)\n"

  if natspec && natspec.head.size > 0
     buf << "#\n#\n"
     natspec.head.each do |line|
        buf <<  (line.empty? ? "#\n" : "#  #{line}\n")
     end
  end
  buf << "\n\n"



  buf << "class  #{name} <  Ethlite::Contract\n\n"

  if address
    buf << "  address "
    buf << %Q{"#{address}"}
    buf << "\n"
  end


  if query_functions.size > 0
    buf << "\n"
    query_functions.each do |func|

      if natspec && (natspec.storage[ func.name] || natspec.functions[ func.name ])
         sect = natspec.storage[ func.name ] || natspec.functions[ func.name ]
         buf << "#  #{sect[0]}\n#\n"
         sect[1].each do |line|
               buf <<  (line.empty? ? "#\n" : "#  #{line}\n")
              end
      else
        buf << "#  #{func.doc} _readonly_\n"
      end



      buf << "def #{func.name}("

      func.inputs.each_with_index do |param,i|
          buf << ", "  if i > 0
          if param.name
             buf << "#{param.name}"
          else
             buf << "arg#{i}"
          end
      end

      buf << ")\n"

      buf << "  do_call("
      buf << %Q{"#{func.name}"}

      func.inputs.each_with_index do |param,i|
        buf << ", "
        if param.name
           buf << "#{param.name}"
        else
           buf << "arg#{i}"
        end
      end

      buf << ")\n"

      buf << "end\n"

      ## note: quick hack - for rdoc/yard doc generation
      ##            move sig method below method
      buf << %Q{sig "#{func.name}"}

      if func.inputs.size > 0
          quoted_types = func.inputs.map {|param| %Q{"#{param.sig}"} }
          buf << ", inputs: [#{quoted_types.join(',')}]"
      end

      if func.outputs.size > 0
        quoted_types = func.outputs.map {|param| %Q{"#{param.sig}"} }
        buf << ", outputs: [#{quoted_types.join(',')}]"
      end
      buf << "\n"





      buf << "\n"
    end
  end


### todo: add (pure) helper functions too!!!
=begin
  if helper_functions.size > 0
    buf << "\n"
    buf << "# #{helper_functions.size} Helper Functions(s)\n\n"
    helper_functions.each do |func|
      buf << "# - #{func.doc}\n"
      ## buf << "  - sig #{func.sig}  =>  0x#{sig(func.sig).hexdigest}\n"
    end
  end
=end

   buf << "end   ## class #{name}\n"
   buf << "\n"
   buf
end

end  ## class Contract
end ##  module ABI
