require './board'
require './tile'

class Game

  attr_reader :board

  def initialize
    @board = Board.new
  end

  def play_turn
    puts @board.render.to_s
    puts "Please enter your coordinate"
    coordinate = gets.chomp
    puts "What action do you want to take reveal or flag or unflag. Ex. r or f or u"
    action = gets.chomp

    row = coordinate.split(',').first.to_i
    col = coordinate.split(',').last.to_i

    case action
    when "r"
      @board[row, col].revealed = true
      @board.check_tile(row,col)
    when "f"
      @board[row, col].is_flagged = true
    when "u"
      @board[row, col].is_flagged = false
    end
    puts @board.render.to_s
  end
end
