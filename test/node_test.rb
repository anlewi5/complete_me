require './test/test_helper'
require_relative '../lib/node'

class TestNode < Minitest::Test

  def test_node_class_exists
    assert_instance_of Node, Node.new
  end

  def test_node_default_instance_variables
    node = Node.new

    assert_equal ({}), node.selected
    assert_equal ({}), node.children
    assert_nil node.term
    refute node.word
  end

end
