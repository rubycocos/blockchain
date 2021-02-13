

module Cryptopunks
  module Dataset

    def self.read( path='./datasets/punks/*.csv' )

      datasets = Dir.glob( path )
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

      rows = []
      datasets.each do |dataset|
        rows += CsvHash.read( dataset )
      end

      # puts "  #{rows.size} rows(s)"
      #=> 10000 rows(s)

      ### wrap in punk struct for easier access
      punks = []
      rows.each do |row|
        id            = row['id'].to_i
        type_q        = row['type']
        count         = row['count'].to_i
        accessories_q = row['accessories'].split( %r{[ ]*/[ ]*} )

        if count != accessories_q.size
          puts "!! ERROR - punk data assertion failed - expected accessories count #{count}; got #{accessories_q.size}"
          pp row
          exit 1
        end

        type = Metadata::Type.find( type_q )
        if type.nil?
          puts "!! ERROR - punk data assertion failed - unknown punk type >#{type_q}<"
          pp row
          exit 1
        end

        accessories = []
        accessories_q.each do |acc_q|
          acc = Metadata::Accessory.find( acc_q )
          if acc.nil?
            puts "!! ERROR - punk data assertion failed - unknown punk accessory type >#{acc_q}<"
            pp row
            exit 1
          end
          accessories << acc
        end

        punks << Metadata.new( id, type, accessories )
      end
      punks
    end
  end  # module Dataset
end  # module Cryptopunks


