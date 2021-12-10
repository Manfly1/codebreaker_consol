# frozen_string_literal: true

RSpec.describe GameRegistrationState do
  subject(:registration_state) { described_class.new(console) }

  let(:console) { Console.new }

  describe '#interact' do
    it do
      allow(console).to receive(:change_state_to)
      expect(registration_state).to receive(:create_game_instances)

      registration_state.interact
    end
  end

  context 'when changing the state' do
    let(:name) { 'a' * CodebreakerManflyy::User::NAME_LENGTH.min }
    let(:difficulty) { ConsoleState::DIFFICULTY_NAMES[:easy] }
    let(:input) { [name, difficulty] }

    before { allow($stdin).to receive(:gets).and_return(*input) }

    it do
      expect(registration_state).to receive(:change_state_to).with(:game_state)
      registration_state.interact
    end
  end
end
