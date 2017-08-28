require './test/test_helper'
require_relative '../lib/node'

class TestNode < Minitest::Test

  def test_node_class_exists
    assert_instance_of Node, Node.new
  end

end
