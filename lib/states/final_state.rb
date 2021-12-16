# frozen_string_literal: true

module States
  class FinalState < BaseState
    def interact
      context.game.win? ? win_scenario : puts(I18n.t('final_state.game_lost', code: string_code))
      ask_to_restart
    end

    private

    def ask_to_restart
      puts(I18n.t('final_state.ask_new_game'))
      return context.change_state_to(States::MenuState.new) unless user_input == YES

      context.game.restart
      context.change_state_to(States::GameState.new)
    end

    def win_scenario
      puts(I18n.t('final_state.game_won', code: string_code))
      puts(I18n.t('final_state.ask_save_game'))
      context.game.save_statistic if user_input == YES
    end

    def string_code
      context.game.code.join
    end
  end
end
