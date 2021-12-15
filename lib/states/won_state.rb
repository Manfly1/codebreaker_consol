# frozen_string_literal: true
module States
class WonState < ConsoleState
  def interact
    puts I18n.t('won_state.game_won', code: @console.game.very_secret_code)
    ask_save_game
    ask_new_game
  end

  private

  def ask_save_game
    puts I18n.t('won_state.ask_save_game')
    input = $stdin.gets.chomp.downcase
    return @console.game.save_game if input == COMMANDS[:yes]

    input == COMMANDS[:no] ? nil : handle_exit_or_unexpected(input, method(:ask_save_game))
  end

  def ask_new_game
    puts I18n.t('won_state.ask_new_game')
    input = $stdin.gets.chomp.downcase
    return change_state_to(:game_state) if input == COMMANDS[:yes]

    input == COMMANDS[:no] ? exit : handle_exit_or_unexpected(input, method(:ask_new_game))
  end
end
end
