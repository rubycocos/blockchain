module Cryptopunks

##################
## 5 punk types
TYPES = [
 { name: 'Alien',  limit: 9 },
 { name: 'Ape',    limit: 24 },
 { name: 'Zombie', limit: 88 },
 { name: 'Female', limit: 3840 },
 { name: 'Male',   limit: 6039 },
]


###
## categories used from:
##   https://cryptoslam.io/cryptopunks/checklist
##     see categories in urls e.g.
##         - cryptopunks/eyes/horned-rim-glasses
##         - cryptopunks/hair/peak-spike
##         - cryptopunks/emotion/smile
##         - etc.
##

#######
## 87 attributes / accessories
##
## note: does NOT include 5 punk types (that is, alien, ape, zombie, female, male)


ACCESSORY_TYPES = [
 { name: 'Mouth',  accessories: [ { name: 'Cigarette',    limit: 961 },
                                  { name: 'Pipe',         limit: 317 },
                                  { name: 'Vape',         limit: 272 },
                                  { name: 'Medical Mask', limit: 175 }]
 },
 { name: 'Nose',   accessories: [ { name: 'Clown Nose', limit: 212 }]
 },
 {
   name: 'Hair',
   accessories: [ { name: 'Wild Blonde',      limit: 144 },
                  { name: 'Wild Hair',        limit: 447 },
                  { name: 'Dark Hair',        limit: 157 },
                  { name: 'Stringy Hair',     limit: 463 },
                  { name: 'Crazy Hair',       limit: 414 },
                  { name: 'Messy Hair',       limit: 460 },
                  { name: 'Mohawk',           limit: 441 },
                  { name: 'Mohawk Thin',      limit: 441 },
                  { name: 'Mohawk Dark',      limit: 429 },
                  { name: 'Peak Spike',       limit: 303 },
                  { name: 'Frumpy Hair',      limit: 442 },
                  { name: 'Clown Hair Green', limit: 148 },
                  { name: 'Shaved Head',      limit: 300 },
                  { name: 'Vampire Hair',     limit: 147 },
                  { name: 'Red Mohawk',       limit: 147 },
                  { name: 'Blonde Bob',       limit: 147 },
                  { name: 'Straight Hair Dark', limit: 148 },
                  { name: 'Straight Hair',    limit: 151 },
                  { name: 'Purple Hair',      limit: 165 },
                  { name: 'Straight Hair Blonde', limit: 144 },
                  { name: 'Wild White Hair',  limit: 136 },
                  { name: 'Half Shaved',      limit: 147 },
                  { name: 'Pigtails',         limit: 94 },
                  { name: 'Orange Side',      limit: 68 },
                  { name: 'Do-rag',           limit: 300 },
                  { name: 'Tiara',            limit: 55 },
                  { name: 'Blonde Short',     limit: 129 },
                  { name: 'Pink With Hat',    limit: 95 },
                  { name: 'Beanie',           limit: 44 },
                  { name: 'Headband', limit: 406 },
                  { name: 'Bandana', limit: 481 },
                  { name: 'Hoodie', limit: 259 },
                  { name: 'Top Hat', limit: 115 },
                  { name: 'Tassle Hat', limit: 178 },
                  { name: 'Cap', limit: 351 },
                  { name: 'Knitted Cap', limit: 419 },
                  { name: 'Cap Forward', limit: 254 },
                  { name: 'Police Cap', limit: 203 },
                  { name: 'Fedora', limit: 186 },
                  { name: 'Pilot Helmet', limit: 54 },
                  { name: 'Cowboy Hat', limit: 142 }]
  },
  {
    name: 'Beard',
    accessories: [{ name: 'Normal Beard', limit: 292 },
                  { name: 'Normal Beard Black', limit: 289 },
                  { name: 'Front Beard Dark', limit: 260 },
                  { name: 'Front Beard', limit: 273 },
                  { name: 'Shadow Beard', limit: 526 },
                  { name: 'Luxurious Beard', limit: 286 },
                  { name: 'Big Beard', limit: 146 },
                  { name: 'Chinstrap', limit: 282 },
                  { name: 'Mustache', limit: 288 },
                  { name: 'Muttonchops', limit: 303 },
                  { name: 'Handlebars', limit: 263 },
                  { name: 'Goat', limit: 295 }]
  },
  {
    name: 'Ears',
    accessories: [{ name: 'Earring', limit: 2459 }]
  },
  {
    name: 'Eyes',
    accessories: [{ name: 'Blue Eye Shadow', limit: 266 },
                  { name: 'Purple Eye Shadow', limit: 262 },
                  { name: 'Green Eye Shadow', limit: 271 },
                  { name: 'Welding Goggles', limit: 86 },
                  { name: 'VR', limit: 332 },
                  { name: '3D Glasses', limit: 286 },
                  { name: 'Clown Eyes Blue', limit: 384 },
                  { name: 'Clown Eyes Green', limit: 382 },
                  { name: 'Small Shades', limit: 378 },
                  { name: 'Regular Shades', limit: 527 },
                  { name: 'Big Shades', limit: 535 },
                  { name: 'Classic Shades', limit: 502 },
                  { name: 'Nerd Glasses', limit: 572 },
                  { name: 'Horned Rim Glasses', limit: 535 },
                  { name: 'Eye Mask', limit: 293 },
                  { name: 'Eye Patch', limit: 461 }]
  },
  {
    name: 'Lips',
    accessories: [{ name: 'Purple Lipstick', limit: 655 },
                  { name: 'Black Lipstick', limit: 617 },
                  { name: 'Hot Lipstick', limit: 696 } ]
  },
  {
    name: 'Face',
    accessories: [{ name: 'Spots', limit: 124 },
                  { name: 'Mole',  limit: 644 }]
  },
  {
    name: 'Neck',
    accessories: [{ name: 'Choker', limit: 48 },
                  { name: 'Silver Chain', limit: 156 },
                  { name: 'Gold Chain', limit: 169 }]
  },
  { name: 'Cheeks', accessories: [{ name: 'Rosy Cheeks', limit: 128 }]
  },
  { name: 'Teeth',  accessories: [{ name: 'Buck Teeth', limit: 78 }]
  },
  { name: 'Emotion', accessories: [{ name: 'Frown', limit: 261 },
                                   { name: 'Smile', limit: 238 }]
  }
]


end # module Cryptopunks
