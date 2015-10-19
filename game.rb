class Game
  attr_accessor :player1, :player2
  attr_reader :moves

  WINNING_LINES = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]

  def initialize
    @moves = []
  end

  def make_move(player, square)
    @moves << Move.new(square, symbol_for_player(player), player)
  end

  def verify_move(currentplayer,square, lastplayer)
    check_range(square) && check_turn(currentplayer, lastplayer) && check_square(square)
  end

  # def check_for_input(square)
    
  #   if square == ""
  #     puts "Please enter a number"
  #     false
  #   else
  #     true
  #   end
  # end

  def check_range(square)
    if square <= 8
      return true
    else
      puts "Numbers is not in correct range"
      return false
    end
  end

  def check_turn(player, correct_player)
    if player == correct_player
      return true
    else
      return false
      puts "It is not your turn"
    end
  end

  def check_square(square)
    if  moves.select { |x,y| x.square==square }.size == 0
      return true
    else
      puts "Square is already taken."
      return false
    end
  end

  def finished?
    winning_game? || drawn_game?
  end

  def board
    empty_board.tap do |board|
      moves.each do |move|
        board[move.square] = move.symbol
      end
    end
  end

  def empty_board
    # Array.new(9, nil)
    [0,1,2,3,4,5,6,7,8]
  end


  def result
    case 
    when winning_game?
      return "#{moves.last.player} won!"
    when drawn_game?
      return "It's a draw!"
    else
      return "Game still in progress."
    end
  end

  def whose_turn
    return player1 if moves.empty?
    moves.last.player == player1 ? player2 : player1
  end

  private
  def winning_game?
    # is there a winner

  end

  def drawn_game?
    # is it a draw
    moves.size == 9
  end


  private
  def symbol_for_player(player)
    case player
    when player1
      return "X"
    when player2
      return "O"
    else
      raise "Oi! That's not one of my players"
    end
  end

  private
  def winning_game?
    !!WINNING_LINES.detect do |winning_line|
      %w(XXX OOO).include?(winning_line.map { |e| board[e] }.join)
    end
  end
end