# frozen_string_literal: true

RSpec.describe States::LostState do
  subject(:lost_state) { described_class.new(console) }

  let(:console) { instance_double(Console) }
  let(:game) { instance_double(CodebreakerManflyy::Game) }
  let(:code) { [1, 2, 3, 4] }
  let(:input) { %w[start rules stats hint yes no exit] }

  describe '#interact' do
    before do
      allow(console).to receive(:change_state_to)
      allow(console).to receive(:game).and_return(game)
      allow(STDIN).to receive(:gets).and_return(*input)
    end

    it 'puts lose message if user has lost' do
      allow(game).to receive(:won?).and_return(false)
      expect { lost_state.interact }.to output(/#{I18n.t('lost_state.game_lost', code: code)}/).to_stdout
    end
  end
end
