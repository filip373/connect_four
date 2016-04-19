require './lib/gameplay'
require './spec/almost_win_conditions'

describe Gameplay do
    
  let(:first_player) { double(name: 'first', symbol: 'x') }
  let(:second_player) { double(name: 'second', symbol: 'y') }
  let(:board) { double(tiles: nil, full?: false, add: nil) }
  let(:win_conditions) { double() }

  describe '#new' do
    context 'when given parameters' do
      subject(:gameplay) { Gameplay.new([first_player, second_player], board, win_conditions) }
      it 'initializes Gameplay object' do
        expect(gameplay).to be_an_instance_of(Gameplay)
      end
    end
  end

  describe '#current_player' do
    context 'when doing first move' do
      subject(:gameplay) { Gameplay.new([first_player, second_player], board, win_conditions) }
      it 'returns first player' do
        expect(gameplay.current_player).to eql(first_player)
      end
    end
  end

  describe '#move' do
    context 'when game is not won' do
      
      it 'adds tile to board' do
        gameplay = Gameplay.new([first_player, second_player], board, double(fulfilled?: false))
        expect(board).to receive(:add).with(1, 'x')
        gameplay.move(1)
      end

      context 'when move wins' do
        subject(:gameplay) { Gameplay.new([first_player, second_player], board, AlmostWinConditions.new) }

        before(:each) { gameplay.move(4) }
        it 'does not advance current player' do
          expect(gameplay.current_player).to eql(first_player)
        end
      end

      context 'when move does not win' do
        subject(:gameplay) { Gameplay.new([first_player, second_player], board, no_win_conditions) }
        let(:no_win_conditions) { double(fulfilled?: false) }
        
        before(:each) { gameplay.move(3) }
        it 'advance current player' do
          expect(gameplay.current_player).to eql(second_player)
        end

        context 'when new turn starts' do
          before(:each) { gameplay.move(4) }
          it 'set current player to first player' do
            expect(gameplay.current_player).to eql(first_player)
          end
        end
      end
    end 

    context 'when game is won' do
      subject(:gameplay) { Gameplay.new([first_player, second_player], board, win_conditions) }
      let(:win_conditions) { double(fulfilled?: true) }
      it 'raises an exception' do
        expect { gameplay.move(1) }.to raise_exception('Game is already won')
      end
    end
  end

  describe '#won?' do
    context 'when game is won' do
      subject(:gameplay) { Gameplay.new([first_player, second_player], board, win_conditions) }
      let(:win_conditions) { double(fulfilled?: true) }
      it 'returns true' do
        expect(gameplay.won?).to be_truthy
      end
    end
    context 'when game is not won' do
      subject(:gameplay) { Gameplay.new([first_player, second_player], board, no_win_conditions) }
      let(:no_win_conditions) { double(fulfilled?: false) }
      it 'returns false' do
        expect(gameplay.won?).to be_falsey
      end
    end
  end

  describe '#finished?' do
    context 'when game is won' do
      subject(:gameplay) { Gameplay.new([first_player, second_player], board, win_conditions) }
      let(:win_conditions) { double(fulfilled?: true) }
      it 'returns true' do
        expect(gameplay.finished?).to be(true)
      end
    end
    context 'when board is full' do
      subject(:gameplay) { Gameplay.new([first_player, second_player], full_board, win_conditions) }
      let(:full_board) { double(full?: true, tiles: nil) }
      let(:win_conditions) { double(fulfilled?: false) }
      it 'returns true' do
        expect(gameplay.finished?).to be(true)
      end
    end
    context 'when game is not finished' do
      subject(:gameplay) { Gameplay.new([first_player, second_player], board, win_conditions) }
      let(:win_conditions) { double(fulfilled?: false) }
      it 'returns false' do
        expect(gameplay.finished?).to be(false)
      end
    end
  end

end
