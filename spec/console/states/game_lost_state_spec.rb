# frozen_string_literal: true

RSpec.describe GameLostState do
  subject(:lost_state) { described_class.new(context) }

  let(:context) { instance_double(Console) }
  let(:game) { instance_double(CodebreakerManflyy::Game) }
  let(:code) { [1, 2, 3, 4] }

  describe '#interact' do
    before do
      allow(context).to receive(:change_state_to)
      allow(context).to receive(:game).and_return(game)
 
    end

    it 'puts lose message if user has lost' do
      allow(game).to receive(:won?).and_return(false)
      expect { lost_state.interact }.to output(/#{I18n.t('win_or_lost.game_lost', code: code)}/).to_stdout
    end
  end
end
