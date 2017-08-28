gem 'simplecov'
gem 'simplecov-json'
require 'simplecov'
SimpleCov.start

gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/node'

class TestNode < Minitest::Test

end
