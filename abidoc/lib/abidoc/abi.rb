class ABI


  def self.read( path )
    data = read_json( path )
    ## pp data
    parse( data )
  end

  def self.parse( data )
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



  def generate_doc( title: 'Contract ABI' )
    buf = ''
    buf << "# #{title}\n\n"

    if @ctor
      buf << "\n"
      buf << "**Constructor**\n\n"
      buf << "- #{@ctor.doc}\n"
      buf << "  - sig #{@ctor.sig}  =>  0x#{sig(@ctor.sig).hexdigest}\n"
    end

    if payable_functions.size > 0
      buf << "\n"
      buf << "**#{payable_functions.size} Payable Function(s)**\n\n"
      payable_functions.each do |func|
        buf << "- #{func.doc} _payable_\n"
        buf << "  - sig #{func.sig}  =>  0x#{sig(func.sig).hexdigest}\n"
      end
    end

    if transact_functions.size > 0
      buf << "\n"
      buf << "**#{transact_functions.size} Transact Functions(s)**\n\n"
      transact_functions.each do |func|
        buf << "- #{func.doc}\n"
        buf << "  - sig #{func.sig}  =>  0x#{sig(func.sig).hexdigest}\n"
      end
    end

    if query_functions.size > 0
      buf << "\n"
      buf << "**#{query_functions.size} Query Functions(s)**\n\n"
      query_functions.each do |func|
        buf << "- #{func.doc} _readonly_\n"
        buf << "  - sig #{func.sig}  =>  0x#{sig(func.sig).hexdigest}\n"
      end
    end

    if helper_functions.size > 0
      buf << "\n"
      buf << "**#{helper_functions.size} Helper Functions(s)**\n\n"
      helper_functions.each do |func|
        buf << "- #{func.doc}\n"
        buf << "  - sig #{func.sig}  =>  0x#{sig(func.sig).hexdigest}\n"
      end
    end

    buf
  end


  def generate_interface   ## interface declarations
    buf = ''
    buf << "interface  name_here {"

    if @ctor
      buf << "\n"
      buf << "// Constructor\n"
      buf << "#{@ctor.decl}\n"
    end

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

end  # class ABI
