module ABI

class Param
  def doc
    buf = ''
    if @internal_type && @internal_type != sig
      buf << "#{@internal_type} "
    else
      buf << "#{sig} "
    end
    buf <<  (@name ?  @name : '_')
    buf
  end
end


class Constructor
  def doc
    buf = "constructor"
    if @inputs.empty?
      buf << "()"
    else
      params = @inputs.map {|param| param.doc }
      buf << "(#{params.join(', ')})"
    end
    buf
  end
end  ## class Constructor

class Function
  def doc
    ## note: text with markdown formatting
    buf = "function **#{@name}**"
    if @inputs.empty?
      buf << "()"
    else
      params = @inputs.map {|param| param.doc }
      buf << "(#{params.join(', ')})"
    end
    if @outputs.empty?
       ## do nothing
    else
      buf << " ⇒ "
      params = @outputs.map {|param| param.doc }
      buf << "(#{params.join(', ')})"
    end
    buf
  end
end  ## class Function


class Event
  def doc
    ## note: text with markdown formatting
    buf = "event **#{@name}**"
    if @inputs.empty?
      buf << "()"
    else
      params = @inputs.map {|param| param.doc }
      buf << "(#{params.join(', ')})"
    end
    buf
  end
end  ## class Event


end  ## module ABI
