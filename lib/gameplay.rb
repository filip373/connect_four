class Gameplay

  def initialize(players, board, win_conditions)
    @players = players
    @board = board
    @win_conditions = win_conditions
    @current_index = 0
  end

  def current_player
    @players[@current_index]
  end

  def move(column)
    raise 'Game is already won' if won?
    @board.add(column, current_player.symbol)
    @current_index = (@current_index + 1) % @players.size unless won?
  end

  def won?
    @win_conditions.fulfilled?(@board.tiles, current_player.symbol)
  end

  def finished?
    won? || @board.full?
  end

end
