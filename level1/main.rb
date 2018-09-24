require 'json'
require 'date'

require_relative 'models/model'
require_relative 'models/car'
require_relative 'models/rental'
require_relative 'json_serializer/base'
require_relative 'json_serializer/rentals'
require_relative 'lib/drivy_manager.rb'


DrivyManager.new(input_filename: 'data/input.json', output_filename: 'output.json').call
