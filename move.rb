class Move
  attr_reader :square, :player, :symbol

  def initialize(square, symbol, player)
    @square = square
    @symbol = symbol
    @player = player
  end
end