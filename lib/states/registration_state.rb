# frozen_string_literal: true

module States
  class RegistrationState < BaseState
    def interact
      ask_username
      ask_difficulty
      context.game = CodebrekerManfly::Game.new(@difficulty, @user)
      context.game.start
      context.change_state_to(States::GameState.new)
    end

    private

    def ask_username
      loop do
        puts I18n.t('registration_state.user_name')
        @user = CodebrekerManfly::User.new(user_input)
        return if @user.valid?

        puts(I18n.t('registration_state.invalid_user_name'))
      end
    end

    def ask_difficulty
      loop do
        puts I18n.t('registration_state.difficulty_message', difficulties: difficulties.keys.join(', '))
        @difficulty = difficulties[user_input]
        return unless @difficulty.nil?

        puts(I18n.t('registration_state.invalid_difficulty_message'))
      end
    end

    def difficulties
      { I18n.t('registration_state.easy_difficulty') => CodebrekerManfly::Difficulty.difficulties(:easy),
        I18n.t('registration_state.medium_difficulty') => CodebrekerManfly::Difficulty.difficulties(:medium),
        I18n.t('registration_state.hell_difficulty') => CodebrekerManfly::Difficulty.difficulties(:hell) }
    end
  end
end
