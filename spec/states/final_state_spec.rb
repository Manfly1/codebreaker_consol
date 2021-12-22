# frozen_string_literal: true

RSpec.describe States::FinalState do
  subject(:state) { described_class.new }

  let(:context) { instance_double(States::ConsoleState) }
  let(:game) { instance_double(CodebrekerManfly::Game) }
  let(:code) { [1, 2, 3, 4] }

  describe '#interact' do
    before do
      state.context = context
      allow(context).to receive(:change_state_to)
      allow(context).to receive(:game).and_return(game)
      allow(game).to receive(:code).and_return(code)
      allow(game).to receive(:restart)
      allow(state).to receive(:user_input).and_return('')
    end

    it 'puts lose message if user has lost' do
      allow(game).to receive(:win?).and_return(false)
      expect { state.interact }.to output(/#{I18n.t('final_state.game_lost', code: code)}/).to_stdout
    end

    it 'puts win message if user has won' do
      allow(game).to receive(:win?).and_return(true)
      expect { state.interact }.to output(/#{I18n.t('final_state.game_won', code: code)}/).to_stdout
    end

    it 'puts save statistic message if user has won' do
      allow(game).to receive(:win?).and_return(true)
      allow(game).to receive(:save_statistic)
      allow(state).to receive(:user_input).and_return(described_class::YES)
      expect { state.interact }.to output(/Wanna save your game?/).to_stdout
    end
  end
end
