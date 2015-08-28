require 'byebug'

class Board

  attr_reader :board

  def initialize
    @board = Array.new(9) { Array.new(9)}
    @bombs = []
    populate_bombs
  end

  def [](row, col)
    @board[row][col]
  end

  def []=(row, col, value)
    @board[row][col] = value
  end

  def populate_bombs
    until @bombs.length == 10
      row = rand(0...9)
      col = rand(0...9)
      @bombs << [row, col] unless @bombs.include?([row, col])
    end
  end

  def populate_hints

    #map through each cord find bombs
    #

    @board.each do |row|
      row.each do |col|

      end
    end
  end

  def perimeter(row,col)
    near_spaces = []
    (-1..1).to_a.each do |x|
      (-1..1).to_a.each do |y|
        near_spaces << [row + x, col + y]
      end
    end
    near_spaces.delete([row, col])
    near_spaces.select! do |cord|
      !cord.include?(-1)
    end
    near_spaces.select! do |cord|
      !cord.include?(9)
    end
  end

  def render
    #loop through the grid and check what tile is at each position
    #display the value

  end

end
