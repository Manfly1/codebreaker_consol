# frozen_string_literal: true

class Console
  attr_accessor :game

  def action
    @context = Context.new
    change_state_to(States::MenuState.new)
  end

  def change_state_to(game_state)
    @game_state = game_state
    @game_state.context = self
    @game_state.interact
  end
end
