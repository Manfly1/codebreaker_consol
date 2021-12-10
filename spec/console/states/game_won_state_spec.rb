# frozen_string_literal: true

RSpec.describe GameWonState do
  subject(:won_state) { described_class.new(console) }

  let(:console) { Console.new }
  let(:method) { instance_double('Method') }
  let(:name) { 'a' * CodebreakerManflyy::User::NAME_LENGTH.min }

  describe '#interact' do
    before do
      console.create_user(name: name)
      console.create_game(difficulty: ConsoleState::DIFFICULTY_NAMES[:hell])
      allow(won_state).to receive(:ask_save_game)
      allow(won_state).to receive(:ask_new_game)
    end
  end

  context 'with user input' do
    let(:commands) { ConsoleState::COMMANDS }

    before do
      allow($stdin).to receive(:gets).and_return(*input)
      allow(method).to receive(:call)
    end

    context 'success' do
      let(:input) { commands[:yes] }

      before do
        console.create_user(name: name)
        console.create_game(difficulty: ConsoleState::DIFFICULTY_NAMES[:hell])
        won_state.ask_save_game
      end
    end

    context 'false' do
      let(:input) { 'incorrect' }
      let(:message) { I18n.t(:unexpected_command) }

      it { expect { won_state.handle_exit_or_unexpected(input, method) }.to output(message).to_stdout }
    end
  end
end
