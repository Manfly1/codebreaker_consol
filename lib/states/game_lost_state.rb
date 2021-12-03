# frozen_string_literal: true

class GameLostState < ConsoleState
  def interact
    puts I18n.t('won_or_lost.game_lost', code: @console.game.secret_code)
    ask_new_game
  end

  private

  def ask_new_game
    puts I18n.t('won_or_lost.ask_new_game')
    input = $stdin.gets.chomp.downcase
    return change_state_to(:game_state) if input == COMMANDS[:yes]

    input == COMMANDS[:no] ? exit : handle_exit_or_unexpected(input, method(:ask_new_game))
  end
end
