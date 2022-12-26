module ABI
class Contract

  def self.read( path )
    data = read_json( path )
    ## pp data
    parse( data )
  end

  def self.parse( data )
    ## note: auto-convert (parse) from json if string passed-in
    data = JSON.parse( data )  if data.is_a?( String )

    ctor =  nil
    funcs = []
    has_fallback = false
    has_receive  = true

    data.each do |o|
       if o['type'] == 'function'
          funcs <<  Function.parse( o )
       elsif o['type'] == 'constructor'
          raise ArgumentError, "constructor already defined; only one declaration allowed"   if ctor
          ctor =  Constructor.parse( o )
       elsif o['type'] == 'event'
       elsif o['type'] == 'receive'
          ## skip for now
          ## e.g.
          ##  {"stateMutability": "payable",
          ##   "type": "receive"}
       elsif o['type'] == 'fallback'
          ## skip for now
          ## e.g.
          ##  {"stateMutability"=>"nonpayable",
          ##   "type"=>"fallback"}
       elsif o['type'] == 'error'
          ##  skip for now
          ## e.g.
          ##  {"inputs":[],
          ##    "name":"ApprovalCallerNotOwnerNorApproved",
          ##    "type":"error"}
       else
         pp o
         raise TypeError, "expected function or event; sorry: got #{o['type']}"
       end
     end
     new( constructor: ctor,
          functions: funcs,
          events: [],
          has_receive: has_receive,
          has_fallback: has_fallback  )
  end



  def initialize( constructor: nil,
                  functions: [],
                  events: [],
                  has_receive: false,
                  has_fallback: false )
      @ctor  =  constructor
      @funcs  = functions
      @events = events
      @has_receive = has_receive
      @has_fallback = has_fallback
  end

  def constructor() @ctor; end
  def functions() @funcs; end

  ###
  ##  how to name functions categories ???
  ##  - use  pay, writer, reader, helper  - why? why not?
  def payable_functions
     @funcs.select { |func| func.payable? }
  end

  def transact_functions    ## add write funcs alias - why? why not?
     @funcs.select { |func| !func.payable? && !func.constant? }
  end

  def query_functions    ## add read funcs alias - why? why not?
    @funcs.select { |func| !func.payable? && !func.pure? && func.constant?  }
  end

  def helper_functions    ## add pure ?? funcs alias - why? why not?
    @funcs.select { |func| func.pure? }
  end

end  # class Contract
end # module ABI
