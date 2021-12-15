# frozen_string_literal: true

require 'bundler/setup'
require 'codebreaker_manflyy'

require 'i18n'

require_relative 'config/app'
require_relative 'lib/errors/stop_game_error'
require_relative 'lib/modules/statistics'
require_relative 'lib/states/console_state'
require_relative 'lib/states/menu_state'
require_relative 'lib/states/registration_state'
require_relative 'lib/states/game_state'
require_relative 'lib/states/won_state'
require_relative 'lib/states/lost_state'
require_relative 'lib/console'
