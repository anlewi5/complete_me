require 'pry'

class Node
  attr_accessor :word,
                :term,
                :select,
                :children
  def initialize
    @select = {}
    @word = false
    @term = term
    @children = {}
  end

  def first_use_of_word(prefix, selected_word)
    select[prefix] = [[1, selected_word]]
  end

  def search_for_word(prefix, selected_word)
    word_exists = false
    select[prefix].map! do |word|
      if selected_word == word[1]
        word[0] += 1
        word_exists = true
      end
    end
    first_use_of_word(prefix, selected_word) if !word_exists
  end

  def search_node_for_prefix(prefix, selected_word)
    binding.pry
    if select.has_key? prefix
      search_for_word(prefix, selected_word)
    else
      select[prefix] = [[1, selected_word]]
    end
    binding.pry
  end

end
