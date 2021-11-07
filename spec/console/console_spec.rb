# frozen_string_literal: true

RSpec.describe Console do
  subject(:console) { described_class.new }

  let(:code) { [4, 4, 4, 4] }
  let(:name) { 'a' * CodebreakerManflyy::User::NAME_LENGTH.min }
  let(:start) { ConsoleState::COMMANDS[:start] }
  let(:exit) { ConsoleState::COMMANDS[:exit] }
  let(:yes) { ConsoleState::COMMANDS[:yes] }
  let(:no)  { ConsoleState::COMMANDS[:no] }
  let(:hint) { ConsoleState::COMMANDS[:hint] }

  before { allow($stdin).to receive(:gets).and_return(*input) }

  context 'when play' do
    let(:difficulty) { ConsoleState::DIFFICULTY_NAMES[:easy] }
    let(:total_attempts) { CodebreakerManflyy::Game::DIFFICULTIES[:easy][:attempts] }
    let(:hints_total) { CodebreakerManflyy::Game::DIFFICULTIES[:easy][:hints] }

    before do
      allow_any_instance_of(CodebreakerManflyy::Game).to receive(:generate_random_code).and_return(code)
      console.interact
    end

    context 'when win and was not saved' do
      let(:name2) { 'b' * CodebreakerManflyy::User::NAME_LENGTH.min }
      let(:input) { [start, name2, difficulty, code.join, no, exit] }
    end
  end

  context 'when changing states' do
    let(:difficulty) { ConsoleState::DIFFICULTY_NAMES[:hell] }
    let(:total_attempts) { CodebreakerManflyy::Game::DIFFICULTIES[:easy][:attempts] }
    let(:hints_total) { CodebreakerManflyy::Game::DIFFICULTIES[:easy][:hints] }

    context 'when move to Game Registration State' do
      let(:input) { [start, exit] }

      it 'changes to GameRegistrationState' do
        allow(console.state).to receive(:interact)
      end
    end

    context 'when move to GameState' do
      let(:input) { [start, name, difficulty, exit] }

      it 'changes to GameRegistrationState' do
        allow(console.state).to receive(:interact)
      end
    end

    context 'when move to LostState' do
      let(:wrong_guess) { CodebreakerManflyy::Game::DIFFICULTIES[:hell][:attempts].times.map { '1111' } }
      let(:input) { [start, name, difficulty, wrong_guess, exit].flatten }

      it 'changes to GameLostState' do
        allow(console.state).to receive(:interact)
      end
    end

    context 'when move from LostState to GameState' do
      let(:wrong_guess) { CodebreakerManflyy::Game::DIFFICULTIES[:hell][:attempts].times.map { '1111' } }
      let(:input) { [start, name, difficulty, wrong_guess, yes, exit].flatten }

      it 'changes to GameState' do
        allow(console.state).to receive(:interact)
      end
    end
  end
end
