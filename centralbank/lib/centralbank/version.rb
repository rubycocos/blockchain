# encoding: utf-8

module Centralbank

  VERSION = '0.2.1'

  def self.root
    "#{File.expand_path( File.dirname(File.dirname(File.dirname(__FILE__))) )}"
  end

end # module Centralbank
