gem 'simplecov'
gem 'simplecov-json'
require 'simplecov'
SimpleCov.start
# coverage/index.html to view

gem 'minitest'
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

class TestCompleteMe < Minitest::Test

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
