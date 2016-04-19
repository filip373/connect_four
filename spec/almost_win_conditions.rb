class AlmostWinConditions

  def initialize
    @won = false
  end

  def fulfilled?(tiles, symbol)
    if @won
      @won
    else
      @won = true
      false
    end
  end

end
