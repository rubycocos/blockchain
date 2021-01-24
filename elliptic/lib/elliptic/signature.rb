module EC

class Signature

  def self.decode_der( der )
    asn1 = OpenSSL::ASN1.decode( der )
    r = asn1.value[0].value.to_i
    s = asn1.value[1].value.to_i
    new(r, s)
  end

  def self.decode_base64( str )
    decode_der( Base64.decode64( str ) )
  end

  class << self
    alias_method :from_der,      :decode_der
    alias_method :from_base64,   :decode_base64
  end



  attr_reader :r, :s
  def initialize(r, s)
    @r, @s = r, s
  end

  def to_der
    asn1 = OpenSSL::ASN1::Sequence.new [
        OpenSSL::ASN1::Integer.new( @r ),
        OpenSSL::ASN1::Integer.new( @s ),
      ]
    asn1.to_der
  end

  def to_base64
     Base64.encode64( to_der ).gsub("\n", '' )
  end
end ## class Signature

end  ## module EC
