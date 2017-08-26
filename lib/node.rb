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

end
