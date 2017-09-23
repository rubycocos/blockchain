# encoding: utf-8
# frozen_string_literal: true

module BlockchainLite
  module Basic
    class Block
      attr_reader :index, :timestamp, :data, :previous_hash, :hash

      def initialize(index, data, previous_hash)
        @index         = index
        @timestamp     = Time.now.utc ## note: use coordinated universal time (utc)
        @data          = data
        @previous_hash = previous_hash
        @hash          = calc_hash
      end

      def calc_hash
        sha = Digest::SHA256.new
        sha.update("#{@index}#{@timestamp}#{@data}#{@previous_hash}")
        sha.hexdigest
      end

      # create genesis (big bang! first) block
      # uses index zero (0) and arbitrary previous_hash ('0')
      def self.first(data = 'Genesis')
        Block.new(0, data, '0')
      end

      def self.next(previous, data = 'Transaction Data...')
        Block.new(previous.index + 1, data, previous.hash)
      end
    end
  end
end
