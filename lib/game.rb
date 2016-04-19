require './lib/gameplay'
require './lib/player'
require './lib/board'
require './lib/win_conditions'

board = Board.new(6, 5)
gameplay = Gameplay.new(
  [Player.new('first', 'X'), Player.new('second', 'O')],
  board,
  WinConditions.new(4)
  )

until gameplay.finished?
  print "#{gameplay.current_player.name}'s turn: "
  input = gets.chomp
  system('clear')
  gameplay.move(input.to_i)
  board.print_tiles
end

if gameplay.won?
  puts "#{gameplay.current_player.name} won!"
else
  puts 'Draw.'
end
