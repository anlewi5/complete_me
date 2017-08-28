require 'simplecov'
SimpleCov.start do
  add_filter "../node_test.rb"
end

require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
