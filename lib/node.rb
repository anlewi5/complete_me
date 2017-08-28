class Node
  attr_accessor :word,
                :term,
                :selected,
                :children
  def initialize
    @selected = {}
    @word = false
    @term = term
    @children = {}
  end
end
