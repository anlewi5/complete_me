require_relative './node'
require 'pry'

class CompleteMe
  attr_accessor :head

  def initialize
    @head = Node.new
    @count = 0
  end

  def split_word(word)
    word.chars
  end

  def insert(word)
    letters = split_word(word)
    total_word = ""
    last = letters.length
    insert_letters(total_word, letters, @head, last)
  end

  def insert_letters(total_word, letters, head, last, count = 0, letter = nil )
    count += 1
    letter = letters.shift
    total_word << letter
    position_of_letters(total_word, letters, head, last, count, letter)
  end

  def position_of_letters(total_word, letters, head, last, count, letter)
    if head.children.has_key?(letter) && count == last
      head.children[letter].term = total_word
      head.children[letter].word = true
      @count += 1
    elsif head.children.has_key?(letter) && count != last
      insert_letters(total_word, letters, head.children[letter], last, count)
    elsif count != last
      current = Node.new
      head.children[letter] = current
      insert_letters(total_word, letters, head.children[letter], last, count)
    else
      last_letter(total_word, letter, head)
    end
  end

  def last_letter(total_word, letter, head)
    current = Node.new
    head.children[letter] = current
    current.word = true
    current.term = total_word
    @count += 1
  end

  def suggest(prefix)
    letters = split_word(prefix)
    last = letters.length
    start_node = prefix_finder(letters, last, @head)
    suggestions = []
    suggestions << add_suggestions(start_node, prefix) if !start_node.selected.empty?
    suggestions << start_node.term if start_node.word
    term_finder(start_node, suggestions).flatten.uniq
  end

  def add_suggestions(start_node, prefix)
    sorted_selection = start_node.selected[prefix].sort{|a| a[0]}
    sorted_selection = sorted_selection.map do |array|
      array[1]
    end
    sorted_selection.reverse
  end

  def prefix_finder(letters, last, current, count = 0)
    count += 1
    letter = letters.shift
    if count != last
      prefix_finder(letters, last, current.children[letter], count)
    else
      current.children[letter]
    end
  end

  def term_finder(start_node, suggestions)
    start_node.children.each_value do |value|
      if value.word && !value.children.empty?
        suggestions << value.term
        term_finder(value, suggestions)
      elsif !value.word
        term_finder(value, suggestions)
      else
        suggestions << value.term
      end
    end
    suggestions
  end

  def select(prefix, selected_word)
    letters = split_word(prefix)
    last = letters.length
    start_node = prefix_finder(letters, last, @head)
    start_node.selected[prefix] = search_for_selected_words(prefix, start_node, selected_word)
  end

  def search_for_selected_words(prefix, start_node, selected_word)
    if start_node.selected.has_key?(prefix)
      selection = times_selected(prefix, start_node, selected_word)
    else
      start_node.selected[prefix] = [[1, selected_word]]
    end
  end

  def times_selected(prefix, start_node, selected_word)
    start_node = start_node.selected[prefix].each do |pre|
      if pre.include?(selected_word)
        pre[0] += 1
      elsif start_node.selected[prefix][-1] == pre
        start_node.selected[prefix] << [0, selected_word]
      end
    end
  end

  def count
    @count
  end

  def populate(words)
    array_of_words = words.split
    array_of_words.each do |word|
      insert(word)
    end
    @count
  end
end
