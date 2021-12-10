# frozen_string_literal: true

class GameMenuState < ConsoleState
  def interact
    puts I18n.t('menu.introduction')
    choose_from_menu
  rescue Errors::StopGameError
    puts I18n.t(:bye_bye)
  end

  private

  def choose_from_menu
    loop do
      puts I18n.t('menu.game_menu_options')
      input = $stdin.gets.chomp.downcase
      menu(input)
    rescue CodebreakerManflyy::Validation::GameError => e
      puts e.message
      retry
    end
  end

  def menu(input)
    case input
    when COMMANDS[:start] then change_state_to(:registration_state)
    when COMMANDS[:rules] then puts I18n.t('menu.rules')
    when COMMANDS[:stats] then puts @console.statistics
    else handle_exit_or_unexpected(input, method(:choose_from_menu))
    end
  end
end
