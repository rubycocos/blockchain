require 'csvreader'

datasets = Dir.glob( './datasets/punks/*.csv')
#=> ["./datasets/punks/0-999.csv",
#    "./datasets/punks/1000-1999.csv",
#    "./datasets/punks/2000-2999.csv",
#    "./datasets/punks/3000-3999.csv",
#    "./datasets/punks/4000-4999.csv",
#    "./datasets/punks/5000-5999.csv",
#    "./datasets/punks/6000-6999.csv",
#    "./datasets/punks/7000-7999.csv",
#    "./datasets/punks/8000-8999.csv",
#    "./datasets/punks/9000-9999.csv"]

punks = []
datasets.each do |dataset|
  punks += CsvHash.read( dataset )
end

puts "  #{punks.size} punk(s)"
#=> 10000 punk(s)


###########################################################
## 1) calculate popularity & raririty of types
counter = Hash.new(0)
punks.each do |punk|
  counter[ punk['type'] ] += 1
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

counter = Hash.new(0)
punks.each do |punk|
  accessories = punk['accessories'].split( %r{[ ]*/[ ]*} )
  accessories.each do |acc|
    counter[ acc ] += 1
  end
end

pp counter.size
#=> 87
pp counter
#=> {"Green Eye Shadow"=>271,
#    "Earring"         =>2459,
#    "Blonde Bob"      =>147,
#    "Smile"           =>238,
#    "Mohawk"          =>441,
#    ...}

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
## 3) calculate popularity & raririty of accessory count

counter = Hash.new(0)
punks.each do |punk|
  counter[ punk['count']] += 1
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

  puts '| %-12s | %4d  (%5.2f %%) |' % [name, count, percent]
end
