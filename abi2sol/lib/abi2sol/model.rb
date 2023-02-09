
module ABI

class Param
  def decl
    buf = String.new('')
    buf << "#{sig} "
    buf << "indexed "   if @indexed
    buf <<  (@name ? @name :  '_')
    ## use inline comment - why? why not?
    if @internal_type && @internal_type != sig
       buf << " /* #{@internal_type} */"
    end
    buf
  end
end  ## class Param


class Constructor
  def decl
      buf = "constructor"
      if @inputs.empty?
        buf << "()"
      else
        params = @inputs.map {|param| param.decl }
        buf << "(#{params.join(', ')})"
      end
      buf << ";"
      buf
  end
end  ## class Constructor

class Function
  def decl
    buf = "function #{@name}"
    if @inputs.empty?
      buf << "()"
    else
      params = @inputs.map {|param| param.decl }
      buf << "(#{params.join(', ')})"
    end
    buf << " payable "  if @payable
    buf << " view "     if @constant && !@pure
    buf << " pure "     if @constant && @pure

    if @outputs.empty?
       ## do nothing
    else
      buf << " returns "
      params = @outputs.map {|param| param.decl }
      buf << "(#{params.join(', ')})"
    end
    buf << ";"
    buf
  end
end  ## class Function


class Event
  def decl
    buf = "event #{@name}"
    if @inputs.empty?
      buf << "()"
    else
      params = @inputs.map {|param| param.decl }
      buf << "(#{params.join(', ')})"
    end
    buf << ";"
    buf
  end
end  ## class Event




end ## module ABI
