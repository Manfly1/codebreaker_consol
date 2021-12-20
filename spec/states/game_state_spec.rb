# frozen_string_literal: true

RSpec.describe States::GameState do
  describe '#interact' do
    subject(:state) { described_class.new }

    let(:context) { instance_double(Console) }
    let(:game) { instance_double(CodebrekerManfly::Game) }
    let(:entered_code) { '1234' }

    before do
      allow(game).to receive(:make_turn)
      allow(game).to receive(:win?).and_return(false)
      allow(game).to receive(:lose?).and_return(false)
      allow(context).to receive(:change_state_to)
      allow(context).to receive(:game).and_return(game)
      state.context = context
    end

    it 'puts message to console' do
      allow(state).to receive(:user_input).and_return(entered_code)
      expect { state.interact }.to output(/Enter a guess/).to_stdout
    end

    it 'puts invalid command message if user has entered invalid command or guess' do
      allow(state).to receive(:user_input).and_return('invalid command or guess')
      guess = instance_double(CodebrekerManfly::Guess)
      allow(guess).to receive(:valid?).and_return(false)
      allow(CodebrekerManfly::Guess).to receive(:new).and_return(guess)
      expect { state.interact }.to output(/#{I18n.t('base_state.wrong_command')}/).to_stdout
    end

    context 'when hint asked' do
      before do
        allow(game).to receive(:take_hint)
        allow(state).to receive(:user_input).and_return(described_class::HINT_COMMAND)
      end

      it "gives a hint if user has entered '#{described_class::HINT_COMMAND}'" do
        allow(game).to receive(:hints_amount).and_return(1)
        allow(state).to receive(:puts)
        state.interact
        expect(game).to have_received(:take_hint)
      end

      it 'puts no hints left message if no hints left' do
        allow(game).to receive(:hints_amount).and_return(0)
        expect { state.interact }.to output(/#{I18n.t('game_state.used_all_hints')}/).to_stdout
      end
    end

    context 'when guess entered' do
      let(:results_state) { instance_double(States::FinalState) }
      let(:guess) { instance_double(CodebrekerManfly::Guess) }
      let(:entered_code) { '1111' }

      before do
        allow(state).to receive(:puts)
        allow(state).to receive(:user_input).and_return(entered_code)
        allow(guess).to receive(:valid?).and_return(true)
        allow(CodebrekerManfly::Guess).to receive(:new).and_return(guess)
        allow(States::FinalState).to receive(:new).and_return(results_state)
      end

      it 'moves to results state if user has won' do
        allow(game).to receive(:win?).and_return(true)
        state.interact
        expect(context).to have_received(:change_state_to).with(results_state)
      end

      it 'moves to results state if user has lost' do
        allow(game).to receive(:lose?).and_return(true)
        state.interact
        expect(context).to have_received(:change_state_to).with(results_state)
      end

      it 'stays itself if user is still playing' do
        state.interact
        expect(context).to have_received(:change_state_to).with(state)
      end
    end
  end
end
