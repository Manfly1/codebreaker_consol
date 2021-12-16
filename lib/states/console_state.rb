# frozen_string_literal: true

module States
  class ConsoleState
    attr_accessor :game

    def action
      @context = States::Context.new
      change_state_to(States::MenuState.new)
    end

    def change_state_to(game_state)
      @game_state = game_state
      @game_state.context = self
      @game_state.interact
    end
  end
end
