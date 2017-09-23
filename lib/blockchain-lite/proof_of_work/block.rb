# encoding: utf-8
# frozen_string_literal: true

module BlockchainLite
  module ProofOfWork
    class Block
      ## proof of work if hash starts with leading zeros (00)
      attr_reader :index, :timestamp, :data, :previous_hash, :nonce, :hash

      def initialize(index, data, previous_hash)
        @index         = index
        @timestamp     = Time.now.utc ## note: use coordinated universal time (utc)
        @data          = data
        @previous_hash = previous_hash
        @nonce, @hash  = compute_hash_with_proof_of_work
      end

      def calc_hash
        sha = Digest::SHA256.new
        sha.update("#{@nonce}#{@index}#{@timestamp}#{@data}#{@previous_hash}")
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

      private

      def compute_hash_with_proof_of_work(difficulty = '00')
        nonce = 0
        loop do
          hash = calc_hash_with_nonce(nonce)
          if hash.start_with?(difficulty)
            # bingo! proof of work if hash starts with leading zeros (00)
            return [nonce, hash]
          else
            # keep trying (and trying and trying)
            nonce += 1
          end
        end
      end

      def calc_hash_with_nonce(nonce = 0)
        sha = Digest::SHA256.new
        sha.update("#{nonce}#{@index}#{@timestamp}#{@data}#{@previous_hash}")
        sha.hexdigest
      end
    end
  end
end
