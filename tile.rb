require './board'

class Tile

  attr_reader :parent, :is_bomb
  attr_accessor :revealed, :value, :is_flagged

  def initialize(parent, position, bomb)
    @parent = parent
    #@value = "*"
    @revealed = false #(revealed or not, flagged)
    @pos = position
    @is_bomb = bomb
    @is_flagged = false
  end

  def value
    if @revealed
      revealed_value
    elsif @is_flagged
      "F"
    else
      "*"#@value
    end
  end


  def neighbors
    @parent.perimeter(@pos)
  end

  def revealed_value
    counter = 0
    neighbors.each do |tile|
      row = tile.first
      col = tile.last
      counter += 1 if @parent.grid[row][col].is_bomb
    end
    if counter > 0 && !@is_bomb
      counter
    elsif @is_bomb
      "B"
    else
      "_"
    end
  end

end
