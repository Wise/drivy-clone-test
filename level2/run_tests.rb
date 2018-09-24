base_dir = File.expand_path(File.join(File.dirname(__FILE__), ""))
test_dir = File.join(base_dir, "tests")

require_relative "models/model.rb"
Dir[File.join(__dir__, 'models', '*.rb')].each { |file| require file }

require 'test/unit'

Test::Unit::AutoRunner.run(true, "tests/tc_car.rb")
Test::Unit::AutoRunner.run(true, "tests/tc_rental.rb")
