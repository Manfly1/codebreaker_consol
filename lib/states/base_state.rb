# frozen_string_literal: true

module States
  class BaseState
    EXIT_COMMAND = I18n.t('base_state.exit_command')
    YES = I18n.t('base_state.apply')
    attr_accessor :context

    def interact
      raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
    end

    private

    def user_input
      command = gets.chomp
      return command unless command == EXIT_COMMAND

      puts(I18n.t('base_state.exit'))
      exit
    end
  end
end
