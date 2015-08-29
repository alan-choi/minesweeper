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

  def check_tile(row,col)
    if self[row,col].revealed_value == "B"
      puts "BOOM!"
      hidden_board
    elsif self[row,col].revealed_value == "_"
      reveal_near(row,col)
    else
      self[row,col].revealed = true
    end
  end

  def reveal_near(row,col)
    queue = [[row,col]]
    until queue.empty?
      first_pos = queue.first
      #puts coord.to_s
      if self[first_pos[0], first_pos[1]].revealed_value.is_a?(Integer)
        self[row,col].revealed = true
        queue.shift
      elsif self[first_pos[0], first_pos[1]].revealed_value == "_"
        self[row,col].revealed = true
        queue.shift
        queue.concat(perimeter([first_pos[0],first_pos[1]]))
      end
    end
    #take next tile and check the revealed values for empty ones
    #push those into a new array to check again
    #if revealed_values is a number change revealed?
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
