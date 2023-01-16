require 'openssl'

##
# 3rd party gems
require 'bytes'

## extend String
class String
  alias_method :hexdigest, :bin_to_hex   ## note: bin_to_hex added via Bytes!!!
end


###
#  try digests (hash functions) in openssl
#
#
# Among the OpenSSL 1.1.1 supported message digest algorithms are:
#
# SHA224, SHA256, SHA384, SHA512, SHA512-224 and SHA512-256
#
# SHA3-224, SHA3-256, SHA3-384 and SHA3-512
#
# BLAKE2s256 and BLAKE2b512
#
# Each of these algorithms can be instantiated using the name:
#
# digest = OpenSSL::Digest.new('SHA256')
#
#  see
#  - https://ruby-doc.org/stdlib-3.0.0/libdoc/openssl/rdoc/OpenSSL/Digest.html



def algos
  ## try openssl digest algos
  names = [
    'md4',
    'md5',
    'ripemd160',
    'sha224',
    'sha256',
    'sha384',
    'sha512',
    'sha512-224',
    'sha512-256',
    'sha3-224',
    'sha3-256',
    'sha3-384',
    'sha3-512',
    'blake2s256',
    'blake2b512'
  ]


   names.each do |name|
      digest = OpenSSL::Digest.new( name )
      if digest
         puts "  #{name}  -> #{digest.name}, digest_length: #{digest.digest_length}, block_length: #{digest.block_length}"
         digest.update( '' )
         hexdigest = digest.digest.hexdigest
         print "    "
         print hexdigest
         print "   - #{hexdigest.size/2} byte(s)\n"
      else
        puts "!! ERROR - no OpenSSL::Digest found / defined for >#{name}<"
        exit 1
      end
   end


   puts
   puts "OpenSSL::Digest.constants:"
   pp OpenSSL::Digest.constants
#=> [:SHA224, :SHA256, :SHA384, :SHA512,
#     :MD4, :MD5,
#     :RIPEMD160,
#     :SHA1, ]


   names = [
    'MD4',
    'MD5',
    'RIPEMD160',
    'SHA224',
    'SHA256',
    'SHA384',
    'SHA512',
#    'SHA512-224',
#    'SHA512-256',
#    'SHA3-224',
#    'SHA3-256',
#    'SHA3-384',
#    'SHA3-512',
#    'BLAKE2s256',
#    'BLAKE2b512'
  ]



   ## get Digest class va Digest
   names.each do |name|
      klass = OpenSSL::Digest( name )
      puts "#{name} => #{klass.name}"
   end

end


algos




def sha256( bin )
  digest = OpenSSL::Digest::SHA256.new
  ## or use OpenSSL::Digest.new( 'SHA256' )
  digest.update( bin )
  digest.digest
end

pp sha256( '' ).hexdigest


def sha3_256( bin )
  digest = OpenSSL::Digest.new( 'SHA3-256' )
  digest.update( bin )
  digest.digest
end

pp sha3_256( '' ).hexdigest


puts "bye"



__END__



$ openssl version
OpenSSL 1.1.1m  14 Dec 2021
$ openssl list -digest-algorithms
RSA-MD4 => MD4
RSA-MD5 => MD5
RSA-MDC2 => MDC2
RSA-RIPEMD160 => RIPEMD160
RSA-SHA1 => SHA1
RSA-SHA1-2 => RSA-SHA1
RSA-SHA224 => SHA224
RSA-SHA256 => SHA256
RSA-SHA3-224 => SHA3-224
RSA-SHA3-256 => SHA3-256
RSA-SHA3-384 => SHA3-384
RSA-SHA3-512 => SHA3-512
RSA-SHA384 => SHA384
RSA-SHA512 => SHA512
RSA-SHA512/224 => SHA512-224
RSA-SHA512/256 => SHA512-256
RSA-SM3 => SM3
BLAKE2b512
BLAKE2s256
id-rsassa-pkcs1-v1_5-with-sha3-224 => SHA3-224
id-rsassa-pkcs1-v1_5-with-sha3-256 => SHA3-256
id-rsassa-pkcs1-v1_5-with-sha3-384 => SHA3-384
id-rsassa-pkcs1-v1_5-with-sha3-512 => SHA3-512
MD4
md4WithRSAEncryption => MD4
MD5
MD5-SHA1
md5WithRSAEncryption => MD5
MDC2
mdc2WithRSA => MDC2
ripemd => RIPEMD160
RIPEMD160
ripemd160WithRSA => RIPEMD160
rmd160 => RIPEMD160
SHA1
sha1WithRSAEncryption => SHA1
SHA224
sha224WithRSAEncryption => SHA224
SHA256
sha256WithRSAEncryption => SHA256
SHA3-224
SHA3-256
SHA3-384
SHA3-512
SHA384
sha384WithRSAEncryption => SHA384
SHA512
SHA512-224
sha512-224WithRSAEncryption => SHA512-224
SHA512-256
sha512-256WithRSAEncryption => SHA512-256
sha512WithRSAEncryption => SHA512
SHAKE128
SHAKE256
SM3
sm3WithRSAEncryption => SM3
ssl3-md5 => MD5
ssl3-sha1 => SHA1
whirlpool


#  or
$ openssl dgst -list
Supported digests:
-blake2b512                -blake2s256                -md4
-md5                       -md5-sha1                  -mdc2
-ripemd                    -ripemd160                 -rmd160
-sha1                      -sha224                    -sha256
-sha3-224                  -sha3-256                  -sha3-384
-sha3-512                  -sha384                    -sha512
-sha512-224                -sha512-256                -shake128
-shake256                  -sm3                       -ssl3-md5
-ssl3-sha1                 -whirlpool


