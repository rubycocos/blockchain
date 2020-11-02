### note: for local testing - add to load path ./lib
##   to test / run use:
##    $  rackup


$LOAD_PATH << './lib'

require 'centralbank'


run Centralbank::Service
