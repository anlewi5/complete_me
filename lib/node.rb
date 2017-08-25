class Node
  attr_accessor :word,
                :letter,
                :children
  def initialize(letter)
    @word = false
    @letter = letter
    @children = []
  end

end
