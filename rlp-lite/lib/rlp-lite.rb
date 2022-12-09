
require_relative "rlp-lite/version"
require_relative "rlp-lite/util"

require_relative "rlp-lite/decoder"
require_relative "rlp-lite/encoder"

require_relative "rlp-lite/sedes/big_endian_int"
require_relative "rlp-lite/sedes/binary"
require_relative "rlp-lite/sedes/list"
require_relative "rlp-lite/sedes"



# Provides an recursive-length prefix (RLP) encoder and decoder.

module Rlp
   ## add constants "inline" here
   ##  (no need to use a Constant namespace - why? why not?)


   ## todo/check   - use encoding -ascii-8bit for source file or ? - why? why not?
   ## use  #b/.b  to ensure binary encoding? - why? why not?

   ## todo/check:  use auto-freeze string literals magic comment - why? why not?
   BYTE_EMPTY = "".b.freeze   # The empty byte is defined as "".
   BYTE_ZERO  = "\x00".b.freeze   # The zero byte is 0x00.
   BYTE_ONE   = "\x01".b.freeze    # The byte one is 0x01.


   SHORT_LENGTH_LIMIT = 56           # The RLP short length limit.
   LONG_LENGTH_LIMIT = (256 ** 8)    # The RLP long length limit.
   PRIMITIVE_PREFIX_OFFSET = 0x80    # The RLP primitive type offset.
   LIST_PREFIX_OFFSET      = 0xc0    # The RLP array type offset.


   INFINITY = (1.0 / 0.0)    # Infinity as constant for convenience.


 # The Rlp module exposes a variety of exceptions grouped as {RlpException}.
 class RlpException < StandardError; end

 # An error-type to point out RLP-encoding errors.
 class EncodingError < RlpException; end

 # An error-type to point out RLP-decoding errors.
 class DecodingError < RlpException; end

 # An error-type to point out RLP-type serialization errors.
 class SerializationError < RlpException; end

 # An error-type to point out RLP-type serialization errors.
 class DeserializationError < RlpException; end

 # A wrapper to represent already RLP-encoded data.
 class Data < String; end


    def self.encoder() @encoder ||= Encoder.new; end
    def self.decoder() @decoder ||= Decoder.new; end


    # Performes an {Rlp::Encoder} on any ruby object.
    #
    # @param obj [Object] any ruby object.
    # @return [String] a packed, RLP-encoded item.
    def self.encode(obj) encoder.perform( obj ); end


    # Performes an {Rlp::Decoder} on any RLP-encoded item.
    #
    # @param rlp [String] a packed, RLP-encoded item.
    # @return [Object] a decoded ruby object.
    def self.decode(rlp) decoder.perform( rlp ); end


end   # module Rlp




####
#  add alternate names / spelling
RLP   = Rlp    #  add all upcase  - why? why not?


