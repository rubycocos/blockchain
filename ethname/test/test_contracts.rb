##
#  to run use
#     ruby -I ./lib -I ./test test/test_contracts.rb


require 'helper'



class TestContracts < MiniTest::Test


def test_contracts
  assert_equal "0xb47e3cd837ddf8e4c57f05d70ab865de6e193bbb", Ethname[ 'PUNKS V2' ]
  assert_equal "0xb47e3cd837ddf8e4c57f05d70ab865de6e193bbb", Ethname[ 'Punks V.2' ]

  assert_equal "0xf07468ead8cf26c752c676e43c814fee9c8cf402", Ethname[ 'PHUNKS' ]
  assert_equal "0xaf9ce4b327a3b690abea6f78eccbfefffbea9fdf", Ethname[ 'SYNTHPUNKS' ]
  assert_equal "0x58e90596c2065befd3060767736c829c18f3474c", Ethname[ 'PUNKBLOCKS' ]
  assert_equal "0x23581767a106ae21c074b2276d25e5c3e136a68b", Ethname[ 'MOONBIRDS' ]


  assert_equal "0x6ba6f2207e343923ba692e5cae646fb0f566db8d", Ethname['punks v1']
  assert_equal "0xb47e3cd837ddf8e4c57f05d70ab865de6e193bbb", Ethname['punks v2']
  assert_equal "0xd33c078c2486b7be0f7b4dda9b14f35163b949e0", Ethname['punks v3']
  assert_equal "0xd12882c8b5d1bccca57c994c6af7d96355590dbd", Ethname['punks v4']

  assert_equal "0xf4a4644e818c2843ba0aabea93af6c80b5984114", Ethname['punks v1 wrapped i']
  assert_equal "0x282bdd42f4eb70e7a9d9f40c8fea0825b7f68c5d", Ethname['punks v1 wrapped ii']

  assert_equal "0xa82f3a61f002f83eba7d184c50bb2a8b359ca1ce", Ethname['phunks v1']
  assert_equal "0xf07468ead8cf26c752c676e43c814fee9c8cf402",  Ethname['phunks v2']
  assert_equal "0xa19f0378a6f3f3361d8e962f3589ec28f4f8f159",  Ethname['phunks v3']

  assert_equal "0xaf9ce4b327a3b690abea6f78eccbfefffbea9fdf",  Ethname['synth punks']

  assert_equal "0x16f5a35647d6f03d5d3da7b35409d65ba03af3b2",  Ethname['punks data']
  assert_equal "0x58e90596c2065befd3060767736c829c18f3474c",  Ethname['punk blocks']

  assert_nil Ethname[ '404 NOT FOUND']
end


def test_find_record
  rec = Ethname::Record.find( '0xaf9CE4B327A3b690ABEA6F78eCCBfeFFfbEa9FDf' )

   assert_equal "0xaf9ce4b327a3b690abea6f78eccbfefffbea9fdf", rec.addr
   assert_equal "0xaf9ce4b327a3b690abea6f78eccbfefffbea9fdf", rec.address
   assert_equal "synth punks", rec.name
   assert_equal ["synth punks", "synthetic punks"], rec.names

   rec = Ethname::Record.find_by( name: 'synth punks' )

   assert_equal "0xaf9ce4b327a3b690abea6f78eccbfefffbea9fdf", rec.addr
   assert_equal "0xaf9ce4b327a3b690abea6f78eccbfefffbea9fdf", rec.address
   assert_equal "synth punks", rec.name
   assert_equal ["synth punks", "synthetic punks"], rec.names
end


end # class TestContracts


