require 'pry-byebug'
require_relative 'game'
require_relative 'move'

puts `clear`
puts "Playing TTT"

def expect(thing, other_thing)
  raise "#{thing} did not equal #{other_thing}" unless thing == other_thing
end

def print_board(g)
  puts(g.board.each_slice(3).map do |row|
        row.map { |e| e || ' ' }.join(' | ')
      end.join("\n---------\n"))
end

g = Game.new

g.player1 = "Michael"
g.player2 = "Neil"

expect(g.class.name, "Game")
expect(g.moves, [])
expect(g.player1, 'Michael')
expect(g.player2, 'Neil')

g.make_move("Michael", 4)
expect g.moves.last.class.name, "Move"
expect g.moves.last.player, "Michael"
expect g.moves.last.square, 4
expect g.moves.last.symbol, "X"

g.make_move "Neil", 0
expect g.moves.last.class.name, "Move"
expect g.moves.last.player, "Neil"
expect g.moves.last.square, 0
expect g.moves.last.symbol, "O"

expect g.finished?, false

g.make_move("Michael", 2)
g.make_move "Neil", 7
g.make_move("Michael", 6)


expect g.finished?, true
expect g.result, "Michael won!"

g = Game.new
puts "What is player 1's name? "
g.player1 = gets.chomp
puts "What is player 2's name? "
g.player2 = gets.chomp

if g.player1 == g.player2
  g.player2 += "2"
end

until g.finished?
  puts `clear`
  puts print_board(g)
  currentplayer = g.whose_turn
  puts "Where's #{currentplayer}'s move?"
  move = gets.chomp.to_i
  until g.verify_move(currentplayer, move, g.whose_turn) == true
    puts "Please try again"
    move = gets.chomp.to_i
  end
  g.make_move(currentplayer, move)
end

puts `clear`
puts print_board(g)
puts g.result