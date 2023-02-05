###
#  to run use
#     ruby -I ./lib sandbox/test_tuples.rb

$LOAD_PATH.unshift( "../abiparser/lib" )
require 'abi2sol'

# name = 'AirSwap'
name = 'BunchaStructs'

abi = ABI.read( "./abis/#{name}.abi.json" )
## pp abi


puts "  #{abi.payable_functions.size} Payable Function(s):"


TUPLES = {}


def generate_tuple( param )
   buf = String.new('')
   buf << "#{param.internal_type} {\n"

   param.components.each do |subparam|
     buf << "   #{subparam.internal_type} #{subparam.name};\n"
   end

   buf << "\n"
   buf
end

def handle_tuple( param )
  tuple = TUPLES[ param.internal_type ] ||= { count: 0,
                                              sig: param.sig,
                                              param: param }

  if tuple[:count] > 0
    ## check if sig match
    if tuple[:sig] != param.sig
       puts "!! ERROR - tuple sig mismatch for:"
       puts tuple[:sig]
       puts param.sig
       exit 1
    end
  end

  tuple[:count] += 1


  if param.components
     param.components.each do |subparam|
         handle_tuple( subparam)   if subparam.type == 'tuple'
     end
  end
end


abi.payable_functions.each do |func|
  puts "==> #{func.decl}"
  func.inputs.each_with_index do |param,i|
    puts "[#{i}] sig: #{param.sig}"
    puts "  type:  #{param.type}"
    puts "  internal type:  #{param.internal_type}"

    ## todo/check:  check for tuple[] or such - possible?
    if param.type.start_with?( 'tuple' )
        handle_tuple( param )
    end
  end
end


puts "tuples:"
pp TUPLES


TUPLES.each do |name, tuple|
  param = tuple[:param]
  puts generate_tuple( param )
end

puts "bye"
