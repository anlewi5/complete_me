require 'simplecov'
SimpleCov.start
gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/tree'

class TestTree < Minitest::Test

  def test_prefix_finder_returns_node_where_term_equals_prefix

  end

end
