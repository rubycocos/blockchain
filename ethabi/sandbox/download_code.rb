################
#   download (source) code via Etherscan

#
#  to run use
#     ruby sandbox/download_code.rb


$LOAD_PATH.unshift( "../etherscan-lite/lib" )
require 'ethname'
require 'etherscan-lite'



def format_code( txt )
  ##  {{ to {
  ## and }} to }
  txt = txt.strip.sub( /\A\{\{/, '{').sub( /\}\}\z/, '}' )

  data = JSON.parse( txt )
  ## pp data

  language = data['language']
  pp language
  if language != 'Solidity'
    puts "!! ERROR - expected Solidity for language; got: #{language}"
    exit 1
  end

  sources = data['sources']
  puts "  #{sources.size} source(s)"

  buf = ''
  sources.each do |name, h|
     buf << "///////////////////////////////////////////\n"
     buf << "// File: #{name}\n\n"
     buf << h['content']
     buf << "\n\n"
  end
  buf
end






puts "  #{Ethname.directory.size} (contract) address record(s)"


delay_in_s = 1

Ethname.directory.records.each_with_index do |rec,i|
  puts "==> [#{i+1}] #{rec.names.join('|')} @ #{rec.addr} supports #{rec.interfaces.join('|')}..."

  outpath_code = "./code/#{rec.addr}.sol"
  outpath_meta = "./code/#{rec.addr}.yml"

  if File.exist?( outpath_code )
     # already download / found in cache
  else
    puts "  sleeping in #{delay_in_s} sec(s)..."
    sleep( delay_in_s )

    data = Etherscan.getsourcecode( address: rec.addr )
    pp data   ## note: returns abi data as a json string (parse again!!)

    ## note: returns an array
    if data.size != 1
      puts "!! ERROR - expected array of size 1; got #{data.size}"
      exit 1
    end

    code = data[0]['SourceCode']

    ## note:  unroll multi-file format if present (starts with {{ .. }})
    code = format_code( code )  if code.start_with?( /[ \t\n\r]*\{\{/ )


    ## fix:  use "universal new line or such ?? - why lines get duplicated??"
    ##  hack: use write_blob
    write_blob( outpath_code, code )

    ## remove SourceCode & ABI entries
    data[0].delete('SourceCode')
    data[0].delete('ABI')
    puts "meta:"
    pp data[0]

    ##  save rest (remaining) as yml
    write_text( outpath_meta, YAML.dump( data[0] ))
  end
end


puts "bye"