class WinConditions

  def initialize(streak_length)
    @streak_length = streak_length
  end

  def fulfilled?(board, symbol)
    return true if fulfilled_vertical?(board, symbol)
    return true if fulfilled_horizontal?(board, symbol)
    return false
  end

  private

  def fulfilled_vertical?(board, symbol)
    board.each do |column|
      streak = 0
      column.each do |cell|
        cell == symbol ? streak += 1 : streak = 0
        return true if streak >= @streak_length
      end
    end
    return false
  end

  def fulfilled_horizontal?(board, symbol)
    streaks = Array.new(board.size, 0)
    board.each do |column|
      column.each_with_index do |cell, cell_index|
        cell == symbol ? streaks[cell_index] += 1 : streaks[cell_index] = 0
      end
      if column.size < streaks.size
        streaks[column.size..-1].each_with_index { |_, index| streaks[index + column.size] = 0 }
      end
      return true if streaks.any? { |streak| streak >= @streak_length }
    end
    return false
  end

end
