require './lib/win_conditions'

describe WinConditions do
  
  describe '#new' do
    context 'when passed streak length' do
      it 'returns an instance of WinConditions' do
        expect(WinConditions.new(5)).to be_an_instance_of(WinConditions)
      end
    end
  end

  describe '#fulfilled?' do

    context 'when streak length = 4' do

      before :each do
        @win_conditions = WinConditions.new(4)
      end
      
      context 'when no streak done' do
        it 'returns false' do
          board = [%w{x x y x}, %w{y y x}, [], %w{y y y x y}, %w{y y x x y}]
          expect(@win_conditions.fulfilled?(board, 'x')).to be_falsey
        end
      end

      context 'when vertical streak done' do
        it 'returns true' do
          board = [%w{x x x x}, [], [], [], []]
          expect(@win_conditions.fulfilled?(board, 'x')).to be_truthy
        end
      end

      context 'when horizontal streak done' do
        it 'returns true' do
          board = [%w{y y z x}, %w{b x y}, %w{a x}, %w{b x i}, %w{b x y y}]
          expect(@win_conditions.fulfilled?(board, 'x')).to be_truthy
        end
      end

    end
  end

end
