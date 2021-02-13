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


ATTRIBUTES = [
 { name: 'Mouth',  values: ['Cigarette',
                            'Pipe',
                            'Vape',
                            'Medical Mask',
                           ]
 },
 { name: 'Nose',   values: ['Clown Nose']
 },
 {
   name: 'Hair',
   values: ['Wild Blonde',
            'Wild Hair',
            'Dark Hair',
            'Stringy Hair',
            'Crazy Hair',
            'Messy Hair',
            'Mohawk',
            'Mohawk Thin',
            'Mohawk Dark',
            'Peak Spike',
            'Frumpy Hair',
            'Clown Hair Green',
            'Shaved Head',
            'Vampire Hair',
            'Red Mohawk',
            'Blonde Bob',
            'Straight Hair Dark',
            'Straight Hair',
            'Purple Hair',
            'Straight Hair Blonde',
            'Wild White Hair',
            'Half Shaved',
            'Pigtails',
            'Orange Side',
            'Do-rag',
            'Tiara',
            'Blonde Short',
            'Pink With Hat',
            'Beanie',
            'Headband',
            'Bandana',
            'Hoodie',
            'Top Hat',
            'Tassle Hat',
            'Cap',
            'Knitted Cap',
            'Cap Forward',
            'Police Cap',
            'Fedora',
            'Pilot Helmet',
            'Cowboy Hat']
  },
  {
    name: 'Beard',
    values: ['Normal Beard',
             'Normal Beard Black',
             'Front Beard Dark',
             'Front Beard',
             'Shadow Beard',
             'Luxurious Beard',
             'Big Beard',
             'Chinstrap',
             'Mustache',
             'Muttonchops',
             'Handlebars',
             'Goat']
  },
  {
    name: 'Ears',
    values: ['Earring']
  },
  {
    name: 'Eyes',
    values: ['Blue Eye Shadow',
             'Purple Eye Shadow',
             'Green Eye Shadow',
             'Welding Goggles',
             'VR',
             '3D Glasses',
             'Clown Eyes Blue',
             'Clown Eyes Green',
             'Small Shades',
             'Regular Shades',
             'Big Shades',
             'Classic Shades',
             'Nerd Glasses',
             'Horned Rim Glasses',
             'Eye Mask',
             'Eye Patch']
  },
  {
    name: 'Lips',
    values: ['Purple Lipstick',
             'Black Lipstick',
             'Hot Lipstick']
  },
  {
    name: 'Face',
    values: ['Spots', 'Mole']
  },
  {
    name: 'Neck',
    values: ['Choker',
             'Silver Chain',
             'Gold Chain']
  },
  { name: 'Cheeks', values: ['Rosy Cheeks']
  },
  { name: 'Teeth',  values: ['Buck Teeth']
  },
  { name: 'Emotion', values: ['Frown',
                              'Smile']
  }
]


end # module Cryptopunks
