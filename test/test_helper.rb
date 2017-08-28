require 'simplecov'
SimpleCov.start do
  add_filter "./test/node_test"
end

require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
