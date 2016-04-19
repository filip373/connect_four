require './lib/board'

describe Board do

  describe '#new' do
    context('when columns and height passed') do
      it 'initializes new board instance' do
        expect(Board.new(3, 5)).to be_an_instance_of(Board)
      end
      it 'initializes tiles array' do
        expect(Board.new(4, 8).tiles).to eql(Array.new(4, []))
      end
    end
  end

  describe '#full?' do
    subject(:board) { Board.new(2, 2) }
    context 'when board is full' do
      before { (0..1).each { |e| 2.times { board.add(e, 'x') } } }
      it 'returns true' do
        expect(board.full?).to be(true)
      end
    end
    context 'when board is not full' do
      it 'returns false' do
        expect(board.full?).to be(false)
      end
    end
  end

  describe '#add' do
    
    before :each do
      @board = Board.new(6, 7)
    end

    context 'when column is not full' do
      it 'adds single tile to empty column' do
        @board.add(4, 'x')
        expect(@board.tiles).to eql([[], [], [], [], ['x'], []])
      end
      it 'adds multiple tiles to one column' do
        @board.add(4, 'x')
        @board.add(4, 'y')
        expect(@board.tiles).to eql([[], [], [], [], ['x', 'y'], []])
      end
      it 'adds multiple tiles to multiple columns' do
        @board.add(4, 'x')
        @board.add(4, 'y')
        @board.add(5, 'x')
        expect(@board.tiles).to eql([[], [], [], [], ['x', 'y'], ['x']])
      end

      context 'when symbol is empty' do
        it 'raises an exception' do
          expect { @board.add(2, '') }.to raise_exception('Symbol size not equal 1')
        end
      end

      context 'when symbol length is above 1' do
        it 'raises an exception' do
          expect { @board.add(1, 'xy') }.to raise_exception('Symbol size not equal 1')
        end
      end
    end
 
    context 'when column is full' do

      before :each do
        7.times { @board.add(3, 'x') }
      end

      it 'raises an exception' do
        expect { @board.add(3, 'y') }.to raise_exception('Column is full')
      end
    end

  end

end
