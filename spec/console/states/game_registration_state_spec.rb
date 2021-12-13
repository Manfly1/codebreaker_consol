# frozen_string_literal: true

RSpec.describe GameRegistrationState do
  describe '#interact' do
    subject(:state) { described_class.new }

    let(:context) { instance_double(Console) }
    let(:game) { instance_double(CodebreakerManflyy::Game) }

    let(:valid_name) { 'a' * (CodebreakerManflyy::User) }
    let(:invalid_name) { 'a' * (CodebreakerManflyy::User::USERNAME_MIN_LENGTH - 1) }
    let(:valid_inputs) { [valid_name, valid_difficulty_name] }
    let(:invalid_name_inputs) { [invalid_name, valid_name, valid_difficulty_name] }
    let(:invalid_difficulty_inputs) { [valid_name, invalid_difficulty_name, valid_difficulty_name] }
    let(:exit_inputs) { [exit_command, valid_name, valid_difficulty_name] }

    before do

      allow(context).to receive(:change_state_to)
      allow(context).to receive(:game).and_return(game)
      allow(game).to receive(:start_new_game)
    end

    it 'puts message to console' do
      allow(state).to receive(:gets).and_return(*valid_inputs)
      expect { state.interact }.to output(/#{I18n.t('registration.ask_user_name')}/).to_stdout
    end

    it 'puts invalid name message to console if name is invalid' do
      allow(state).to receive(:gets).and_return(*invalid_name_inputs)
      expect { state.interact }.to output(/Invalid user name/).to_stdout
    end

    it "puts exit message and exits from the game if user has entered #{Errors::StopGameError}" do
      allow(state).to receive(:gets).and_return(*exit_inputs)
      allow(state).to receive(:exit)
      expect { state.interact }.to output(/#{I18n.t(:exit_message)}/).to_stdout
    end
  end
end
