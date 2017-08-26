require_relative './node'

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
    suggestions << start_node.term if start_node.word
    term_finder(start_node, suggestions)
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
    prefix_node = prefix_finder(letters, last, @head)
    prefix_node.search_node_for_prefix(prefix, selected_word)
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
    if select.has_key prefix
      search_for_word(prefix, selected_word)
    else
      select[prefix] = [[1, selected_word]]
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
