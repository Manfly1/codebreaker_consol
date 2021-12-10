# frozen_string_literal: true

RSpec.describe GameLostState do
  subject(:lost_state) { described_class.new(console) }

  let(:console) { Console.new }
  let(:method) { instance_double('Method') }

  describe '#interact' do
    context 'success' do
      it 'change state' do
        console.create_game(difficulty: ConsoleState::DIFFICULTY_NAMES[:hell])
        allow(lost_state).to receive(:ask_new_game)
      end
    end
  end
  context 'false' do
    let(:commands) { ConsoleState::COMMANDS }

    before do
      allow($stdin).to receive(:gets).and_return(*input)
      allow(method).to receive(:call)
    end

    context 'close app' do
      let(:input) { 'incorrect' }
      let(:message) { I18n.t(:unexpected_command) }

      it { expect { lost_state.handle_exit_or_unexpected(input, method) }.to output(message).to_stdout }
    end
  end
end
