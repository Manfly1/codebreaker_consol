# frozen_string_literal: true
module States
class LostState < ConsoleState
  def interact
    puts I18n.t('lost_state.game_lost', code: @console.game.very_secret_code)
    ask_new_game
  end

  private

  def ask_new_game
    puts I18n.t('lost_state.ask_new_game')
    input = $stdin.gets.chomp.downcase
    return change_state_to(:game_state) if input == COMMANDS[:yes]

    input == COMMANDS[:no] ? exit : handle_exit_or_unexpected(input, method(:ask_new_game))
  end
end
end
