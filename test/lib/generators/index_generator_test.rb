require 'test_helper'
require 'generators/index/index_generator'

class IndexGeneratorTest < Rails::Generators::TestCase
  tests IndexGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
