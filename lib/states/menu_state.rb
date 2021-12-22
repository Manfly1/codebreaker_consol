# frozen_string_literal: true

module States
  class MenuState < BaseState
    def interact
      puts(I18n.t('menu_state.introduction'))
      puts(I18n.t('menu_state.game_menu_options', start: 'start', rules: 'rules', stats: 'stats',
                                                  exit: EXIT_COMMAND))
      command = user_input
      context.change_state_to(manage_command(command))
    end

    private

    def manage_command(command)
      case command
      when 'start' then return States::RegistrationState.new
      when 'rules' then puts(I18n.t('menu_state.rules'))
      when 'stats' then print_statistic
      else
        puts I18n.t('base_state.wrong_command')
      end

      self
    end

    def print_statistic
      puts(I18n.t('menu_state.stats_title'))

      stats = CodebrekerManfly::Game.user_statistic
      return puts(I18n.t('menu_state.stats_empty')) if stats.empty?

      formated_stats = stats.map.with_index do |stat, index|
        I18n.t('menu_state.stats_body', **stats_to_hash(index, stat))
      end.join
      puts(formated_stats)
    end

    def stats_to_hash(index, stat)
      {
        rating: index + 1,
        name: stat.user.name,
        difficulty: stat.difficulty.name,
        total_attempts: stat.difficulty.attempts,
        used_attempts: stat.attempts,
        total_hints: stat.difficulty.hints,
        used_hints: stat.hints
      }
    end
  end
end
