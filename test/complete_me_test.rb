require './test/test_helper'
require_relative '../lib/complete_me'

class CompleteMeTest < Minitest::Test

  attr_reader :cm, :cma

  def setup
    @cm = CompleteMe.new
    @cma = CompleteMe.new
  end

  def test_complete_me_class_exists
    assert_instance_of CompleteMe, cm
  end

  def test_splits_word
    assert_equal ["a"], cm.split_word("a")
    assert_equal ["a","n", "n", "a"], cm.split_word("anna")
    assert_equal ["m", "i", "g", "u", "e", "l"], cm.split_word("miguel")
  end

  def test_starting_count
    assert_equal 0, cm.count
  end

  def test_insert_letters
    assert_equal 1,cm.insert_letters('', ['a', 'b', 'c'], cm.head, 3)
  end

  def test_position_of_letters
    assert 1, cm.position_of_letters('a', ['b', 'c'], cm.head, 3, 1, 'a')
  end

  def test_last_letter
    assert_equal 1, cm.last_letter('ab', 'c', cm.head)
  end

  def test_inserts_single_word
    cm.insert("pizza")
    assert_equal 1, cm.count
  end

  def test_inserts_multiple_words
    cm.populate("pizza\ndog\ncat")
    assert_equal 3, cm.count
  end

  # def test_inserts_csv_addresses_large
  #   cma.populate_csv("./test/data/addresses.csv")
  #   assert_equal 306013, cma.count
  # end

  def test_counts_inserted_words
    insert_words(["pizza", "aardvark", "zombies", "a", "xylophones"])
    assert_equal 5, cm.count
  end

  def test_prefix_finder_returns_a_node
    insert_words(["a"])

    assert_instance_of Node, cm.prefix_finder(["a"], 1, cm.head)
  end

  def test_term_finder    
    assert_equal [], cm.term_finder(cm.head, [])
  end

#not passing
  def test_add_suggestions
    insert_words(["pizza", "aardvark", "zombies", "a", "xylophones"])
    assert_equal 5, cm.add_suggestions(cm.head, "piz")
  end

  def test_search_for_selected_words
    assert_equal [[1, "piz"]], cm.search_for_selected_words("piz", cm.head, "piz")
  end

#not passing
  def test_times_selected
    cm.populate(medium_word_list)
    cm.select("wi", "wizardly")

    assert_equal 5, cm.times_selected("wi", cm.head, "wizardly")
  end

  def test_suggests_off_of_small_dataset
    insert_words(["pizza", "aardvark", "zombies", "a", "xylophones"])
    assert_equal ["pizza"], cm.suggest("p")
    assert_equal ["pizza"], cm.suggest("piz")
    assert_equal ["zombies"], cm.suggest("zo")
    assert_equal ["a", "aardvark"], cm.suggest("a").sort
    assert_equal ["aardvark"], cm.suggest("aa")
  end

  def test_inserts_medium_dataset
    cm.populate(medium_word_list)
    assert_equal medium_word_list.split("\n").count, cm.count
  end

  def test_suggests_off_of_medium_dataset
    cm.populate(medium_word_list)
    assert_equal ["williwaw", "wizardly"], cm.suggest("wi").sort
  end

  def test_selects_off_of_medium_dataset
    cm.populate(medium_word_list)
    cm.select("wi", "wizardly")
    assert_equal ["wizardly", "williwaw"], cm.suggest("wi")
  end

  def test_selects_off_of_medium_dataset
    cm.insert("wizard")
    cm.insert("wizardly")
    cm.insert("williwaw")
    cm.select("wiz", "wizard")
    cm.select("wiz", "wizardly")
    assert_equal ["wizard", "wizardly", "williwaw"], cm.suggest("wi")
  end

  def test_selects_off_of_medium_dataset_with_repeated_select
    cm.populate(medium_word_list)
    cm.select("wi", "wizardly")
    cm.select("wi", "wizardly")
    assert_equal ["wizardly", "williwaw"], cm.suggest("wi")
  end

  def test_works_with_large_dataset
    cm.populate(large_word_list)
    assert_equal ["doggerel", "doggereler", "doggerelism", "doggerelist", "doggerelize", "doggerelizer"], cm.suggest("doggerel").sort
    cm.select("doggerel", "doggerelist")
    assert_equal "doggerelist", cm.suggest("doggerel").first
  end

  def insert_words(words)
    cm.populate(words.join("\n"))
  end

  def medium_word_list
    File.read("./test/data/medium.txt")
  end

  def large_word_list
    File.read("/usr/share/dict/words")
  end

end
