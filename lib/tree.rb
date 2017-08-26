require './node'
require 'pry'
class Tree
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
    total_words = ""
    last = letters.length
    insert_letters(total_words, letters, @head, last)
  end

  def insert_letters(total_words, letters, head, last, count = 0)
    count += 1
    letter = letters.shift
    total_words << letter
    if head.children.has_key?(letter) && count != last
      insert_letters(total_words, letters, head.children[letter], last, count)
    elsif count != last
      head.children[letter] = Node.new
      insert_letters(total_words, letters, head.children[letter], last, count)
    else
      current = Node.new
      head.children[letter] = current
      current.word = true
      current.term = total_words
      @count += 1
    end
  end

  def suggest(prefix)

  end

  def select(prefix, selected_word)

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
# binding.pry
tree = Tree.new

# p tree.insert("")
# tree.insert("artem")
