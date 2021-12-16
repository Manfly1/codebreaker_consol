# frozen_string_literal: true

module States
  class GameState < BaseState
    HINT_COMMAND = I18n.t('game_state.hint_command')

    def interact
      puts(I18n.t('game_state.ask_guess', hint_command: HINT_COMMAND, exit_command: EXIT_COMMAND))
      manage_command(user_input)
      context.change_state_to(next_state)
    end

    private

    def manage_command(command)
      command == HINT_COMMAND ? give_hint : make_turn(command)
    end

    def give_hint
      if @context.game.hints_amount.positive?
        puts(I18n.t('game_state.show_hint', digit: context.game.take_hint))
      else
        puts(I18n.t('game_state.used_all_hints'))
      end
    end

    def make_turn(code)
      guess = CodebrekerManfly::Guess.new(code)
      return puts(I18n.t('base_state.wrong_command')) unless guess.valid?

      puts(I18n.t('game_state.coincidence', match: context.game.make_turn(guess)))
    end

    def next_state
      context.game.win? || context.game.lose? ? States::FinalState.new : self
    end
  end
end
