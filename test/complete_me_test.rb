gem 'simplecov'
require 'simplecov'
SimpleCov.start
# coverage/index.html to view

require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/complete_me'

# Basic Specs:
# Insert a single word to the autocomplete dictionary
# Count the number of words in the dictionary
# Populate a newline-separated list of words into the dictionary
# Suggest completions for a substring
# Mark a selection for a substring
# Weight subsequent suggestions based on previous selections

class CompleteMeTest < Minitest::Test

  attr_reader :cm

  def setup
    @cm = CompleteMe.new
  end

  def test_starting_count
    assert_equal 0, cm.count
  end

  def test_inserts_single_word
    cm.insert("pizza")
    assert_equal 1, cm.count
  end

  def test_inserts_multiple_words
    cm.populate("pizza\ndog\ncat")
    assert_equal 3, cm.count
  end

  def test_counts_inserted_words
    insert_words(["pizza", "aardvark", "zombies", "a", "xylophones"])
    assert_equal 5, cm.count
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
    File.read("./data/medium.txt")
  end

  def large_word_list
    File.read("/usr/share/dict/words")
  end

  def test_insert_adds_word_to_dictionary

  end

  def test_count_returns_number_of_words_in_dictionary

  end

  def test_populate_adds_list_of_words_to_dictionary

  end

  def test_suggest_suggests_completions_for_substring

  end

  def test_select_adds_preferred_selection_to_begining_of_suggestions

  end

end
