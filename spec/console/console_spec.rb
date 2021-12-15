# frozen_string_literal: true

RSpec.describe Console do
  subject(:console) { described_class.new }

  let(:code) { [4, 4, 4, 4] }
  let(:name) { 'a' * CodebreakerManflyy::User::NAME_LENGTH.min }
  let(:start) { States::ConsoleState::COMMANDS[:start] }
  let(:exit) { States::ConsoleState::COMMANDS[:exit] }
  let(:yes) { States::ConsoleState::COMMANDS[:yes] }
  let(:no)  { States::ConsoleState::COMMANDS[:no] }
  let(:hint) { States::ConsoleState::COMMANDS[:hint] }
  let(:won_state) { instance_double(States::WonState) }
  let(:lost_state) { instance_double(States::LostState) }
  let(:entered_code) { '1111' }


    before do
      allow(console).to receive(:puts)
      allow(console).to receive(:handle_exit_or_unexpected).and_return(entered_code)
      allow(States::WonState).to receive(:new).and_return(results_state)
      allow_any_instance_of(CodebreakerManflyy::Game).to receive(:generate_random_code).and_return(code)
      console.interact
    end

  describe 'when changing states' do

    context 'when move to Registration State' do

      it 'changes to RegistrationState' do
        allow(console.state).to receive(:interact)
      end
    end
 
      it 'moves to won state if user has won' do
        allow(game).to receive(:won?).and_return(true)
        console.interact
        expect(context).to have_received(:change_state_to).with(won_state)
      end

      it 'moves to lost state if user has lost' do
        allow(game).to receive(:lose?).and_return(true)
        console.interact
        expect(context).to have_received(:change_state_to).with(lost_state)
      end

    context 'when move from LostState to GameState' do
      let(:wrong_guess) { CodebreakerManflyy::Game::DIFFICULTIES[:hell][:attempts].times.map { '1111' } }
      it 'changes to GameState' do
        allow(console.state).to receive(:interact)
      end
    end
  end
end
