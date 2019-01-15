#!/usr/bin/ruby
require_relative 'board'

class Game
  def initialize
    @board = Board.new(8, 8)
    @board.plant_mines(20)
    @board.assign_mine_counts
    @board.display
  end
  
  def start
    puts "Initializing game..\n"
    puts "Ready to play!  Please enter a number on the board\n"
    while true do
        id = $stdin.gets.chomp
        result = @board.play(id.to_i)
        puts result
        if result == 'Boom!'
            @board.display(true)
            break
        end
        if @board.finish?
          print 'Yay!  You won.'
          break
        end
        @board.display()
    end
  end
end
