###########
# to run use:
#  $  ruby -I lib script/accessories.rb


require 'cryptopunks'


punks = Punks::Dataset.read( './datasets/punks/*.csv' )
puts "  #{punks.size} punk(s)"
#=> 10000 punk(s)

pp punks[0]
pp punks[1]
pp punks[2]

punk = punks[0]
pp punk.id
pp punk.type.name
pp punk.accessories
pp punk.accessories[0].name
pp punk.accessories[0].type.name



###########################################################
## 1) calculate popularity & raririty of types
counter = Hash.new(0)
punks.each do |punk|
  counter[ punk.type.name ] += 1
end

pp counter.size
#=> 5
pp counter
#=> {"Female"=>3840, "Male"=>6039, "Zombie"=>88, "Ape"=>24, "Alien"=>9}

## sort by count
counter = counter.sort { |l,r| l[1]<=>r[1] }
pp counter
#=> [["Alien", 9], ["Ape", 24], ["Zombie", 88], ["Female", 3840], ["Male", 6039]]

## pretty print
counter.each do |rec|
  name    = rec[0]
  count   = rec[1]
  percent =  Float(count*100)/Float(punks.size)

  puts '| %-12s | %4d  (%5.2f %%) |' % [name, count, percent]
end


########################################################
## 2) calculate popularity & raririty of accessories

counter = {}
punks.each do |punk|
  punk.accessories.each do |acc|
    rec = counter[ acc.name ] ||= { count: 0,
                                    by_type: Hash.new(0)
                                  }

    rec[ :count ] += 1
    rec[ :by_type ][ punk.type.name ] += 1
  end
end

pp counter.size
#=> 87
pp counter
#=>



## sort by count
counter = counter.sort { |l,r| l[1][:count]<=>r[1][:count] }
pp counter
#=> [["Beanie", 44],
#    ["Choker", 48],
#    ["Pilot Helmet", 54],
#    ["Tiara", 55],
#    ["Orange Side", 68],
#    ...}


## pretty print
counter.each do |rec|
  name    = rec[0]
  count   = rec[1][:count]
  percent =  Float(count*100)/Float(punks.size)

  print '%-20s | %4d  (%5.2f %%) | ' % [name, count, percent]

  ## add by type - highest first (lowest last)
  types = rec[1][:by_type]
  types = types.sort { |l,r| r[1]<=>l[1] }

  print types.map {|type| "#{type[0]} (#{type[1]})" }.join( ' · ')
  print "\n"


  ### double check hard-coded limits
  acc = Punks::Metadata::Accessory.find( name )
  if acc.limit != count
    puts "!! ERROR - punk data assertion failed - accessory >#{name}< count expected #{acc.limit}; got #{count}:"
    pp rec
    exit 1
  end
end




##########################################################
## 3) calculate popularity & raririty of accessories by accessory type (12)

counters = {}
punks.each do |punk|
  punk.accessories.each do |acc|
    counter = counters[ acc.type.name ] ||= Hash.new( 0 )
    counter[ acc.name ] += 1
  end
end

pp counters.size
#=> 12
pp counters
#=> "Ears"=>{"Earring"=>2459},
#   "Hair"=>
#     {"Blonde Bob"=>147,
#      "Mohawk"=>441,
#      "Wild Hair"=>447,
#  "Half Shaved"=>147,
    ...
#


## pretty print
counters.each do |type, counter|

  ## sort by count
  counter = counter.sort { |l,r| l[1]<=>r[1] }

  puts
  puts "#{type} (#{counter.size}):"

  counter.each do |rec|
    name    = rec[0]
    count   = rec[1]
    percent =  Float(count*100)/Float(punks.size)

    puts '| %-20s | %4d  (%5.2f %%) |' % [name, count, percent]
  end
end



## sort by count
counter = counter.sort { |l,r| l[1]<=>r[1] }
pp counter
#=> [["Beanie", 44],
#    ["Choker", 48],
#    ["Pilot Helmet", 54],
#    ["Tiara", 55],
#    ["Orange Side", 68],
#    ...}


## pretty print
counter.each do |rec|
  name    = rec[0]
  count   = rec[1]
  percent =  Float(count*100)/Float(punks.size)

  puts '| %-20s | %4d  (%5.2f %%) |' % [name, count, percent]
end






###############################
## 4) calculate popularity & raririty of accessory count

counter = Hash.new(0)
punks.each do |punk|
  counter[ punk.accessories.size ] += 1
end


pp counter.size
#=> 8
pp counter
#=> {"3"=>4501, "2"=>3560, "1"=>333, "4"=>1420, "5"=>166, "0"=>8, "6"=>11, "7"=>1}



## sort by count 0,1,2,etc.
counter = counter.sort { |l,r| l[0]<=>r[0] }
pp counter
#=> [["0", 8],
#    ["1", 333],
#    ["2", 3560],
#    ["3", 4501],
#    ["4", 1420],
#    ...
#   ]


## pretty print
counter.each do |rec|
  name    = rec[0]
  count   = rec[1]
  percent =  Float(count*100)/Float(punks.size)

  puts '%-12s | %4d  (%5.2f %%)' % [name, count, percent]
end

