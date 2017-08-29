require './test/test_helper'
require_relative '../lib/complete_me'

class CompleteMeTest < Minitest::Test

  attr_reader :cm, :cma

  def test_insert_letters
    cm = CompleteMe.new
    cm.insert("anna")
    assert_equal 5, cm.insert_letters("", ["a","n", "n", "a"], @head, 4)
  end

end
