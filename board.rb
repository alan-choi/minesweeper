require 'byebug'
require './tile'

class Board

  attr_reader :board, :grid

  def initialize
    @bombs = []
    populate_bombs
    @grid = Array.new(9) { Array.new(9)}
    initialize_tiles
  end

  def [](row, col)
    @grid[row][col]
  end

  def []=(row, col, value)
    @grid[row][col] = value
  end

  def populate_bombs
    until @bombs.length == 10
      row = rand(0...9)
      col = rand(0...9)
      @bombs << [row, col] unless @bombs.include?([row, col])
    end
  end

  def initialize_tiles
    @grid.length.times do |row_idx|
      @grid.length.times do |col_idx|
        bomb = @bombs.include?([row_idx, col_idx])
        self[row_idx, col_idx] = Tile.new(self,[row_idx, col_idx], bomb)
      end
    end
  end

  def render
    display = []

    @grid.length.times do |row_idx|
      empty_row =[]
      @grid.length.times do |col_idx|
        empty_row << self[row_idx, col_idx].value
      end
      display << empty_row
    end
    display
  end

  def hidden_board
    display = []

    @grid.length.times do |row_idx|
      empty_row =[]
      @grid.length.times do |col_idx|
        empty_row << self[row_idx, col_idx].revealed_value
      end
      display << empty_row
    end
    display
  end


  def perimeter(pos)
    near_spaces = []
    row,col = pos

    (-1..1).to_a.each do |x|
      (-1..1).to_a.each do |y|
        near_spaces << [row + x, col + y]
      end
    end
    near_spaces.delete([row, col])
    near = near_spaces.reject do |cord|
        cord.include?(-1) || cord.include?(9)
    end
    near
  end
end
