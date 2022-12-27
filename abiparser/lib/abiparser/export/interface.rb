module ABI
class Contract


  def generate_interface( name: )   ## interface declarations
    buf = ''
    buf << "interface #{name} {"


#  include constructor - why? why not?
#
#   if @ctor
#      buf << "\n"
#      buf << "// Constructor\n"
#      buf << "#{@ctor.decl}\n"
#    end

    if payable_functions.size > 0
      buf << "\n"
      buf << "// #{payable_functions.size} Payable Function(s)\n"
      payable_functions.each do |func|
        buf << "#{func.decl}\n"
      end
    end

    if transact_functions.size > 0
      buf << "\n"
      buf << "// #{transact_functions.size} Transact Functions(s)\n"
      transact_functions.each do |func|
        buf << "#{func.decl}\n"
      end
    end

    if query_functions.size > 0
      buf << "\n"
      buf << "// #{query_functions.size} Query Functions(s)\n"
      query_functions.each do |func|
        buf << "#{func.decl}\n"
      end
    end

    if helper_functions.size > 0
      buf << "\n"
      buf << "// #{helper_functions.size} Helper Functions(s)\n\n"
      helper_functions.each do |func|
        buf << "#{func.decl}\n"
      end
    end

    buf << "}\n"
    buf
  end


end  ## class Contract
end  ## module ABI
