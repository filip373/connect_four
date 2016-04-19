class Board

  attr_reader :tiles

  def initialize(columns, height)
    @columns = columns
    @height = height
    @tiles = Array.new(columns) { [] }
  end

  def add(column, symbol)
    raise 'Column is full' unless @tiles[column].size < @height
    raise 'Symbol size not equal 1' unless symbol.to_s.size == 1
    @tiles[column].push(symbol.to_s)
  end

  def full?
    @tiles.any? { |column| column.size < @height } ? false : true
  end

  def print_tiles
    @height.times do |index|
      @columns.times do |column|
        print (" #{tiles[column][@height - 1 - index] || '~'} ")
      end
      puts
    end
  end

end
