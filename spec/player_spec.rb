require './lib/player'

describe Player do
  context '#new' do
    context 'when given name and symbol' do

      before :each do
        @player = Player.new('first', 'x')
      end

      it 'returns instance of Player' do
        expect(@player).to be_an_instance_of(Player)
      end

      it 'initialize and gets correct name' do
        expect(@player.name).to eql('first')
      end

      it 'initialize and gets correct symbol' do
        expect(@player.symbol).to eql('x')
      end

    end
  end
end
