# frozen_string_literal: true

class GameState < ConsoleState
  def interact
    @console.game.start_new_game
    play_game
  end

  private

  def play_game
    loop do
      puts I18n.t('game.ask_guess', length: CODE_LENGTH, min: DIGIT_MIN_MAX[0], max: DIGIT_MIN_MAX[-1],
                                    hint: COMMANDS[:hint], exit: COMMANDS[:exit])
      input = $stdin.gets.chomp

      menu(input)

    rescue CodebreakerManflyy::Validation::GameError => e
      puts e.message
      retry
    end
  end

  def menu(input)
    return puts I18n.t('game.show_hint', hint: @console.game.show_hint) if input == COMMANDS[:hint]

    input == COMMANDS[:exit] ? (raise Errors::StopGameError) : guess_handler(input)

    change_state_if_won_or_lost
  end

  def guess_handler(input)
    puts I18n.t('game.your_guess_is', guess: input)
    @console.game.guess(input)
    puts I18n.t('game.show_clues', clues: show_fancy_clues)
  end

  def show_fancy_clues
    @console.game.clues.map { |clue| Console::FANCY_CLUES[clue] }.compact
  end

  def change_state_if_won_or_lost
    change_state_to(:won_state) if @console.game.won?
    change_state_to(:lost_state) if @console.game.lost?
  end
end
