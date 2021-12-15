# frozen_string_literal: true

class Console
  include Statistics

  attr_reader :user, :game, :state

  STATES = {
    menu_state: States::MenuState,
    registration_state: States::RegistrationState,
    game_state: States::GameState,
    won_state: States::WonState,
    lost_state: States::LostState
  }.freeze

  FANCY_CLUES = {
    exact: '+',
    non_exact: '-'
  }.freeze

  def initialize
    @state = states(:menu_state)
    @user = nil
    @game = nil
  end

  def create_user(name:)
    @user = CodebreakerManflyy::User.new(name: name)
  end

  def create_game(difficulty:)
    @game = CodebreakerManflyy::Game.new(difficulty: difficulty, user: @user)
  end

  def interact
    @state.interact
  end

  def change_state_to(state)
    @state = states(state)
    interact
  end

  def states(state)
    STATES[state].new(self)
  end
end
