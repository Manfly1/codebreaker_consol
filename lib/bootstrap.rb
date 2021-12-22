# frozen_string_literal: true

require 'bundler/setup'
require 'codebreker_manfly'

require 'i18n'

require_relative '../config/app'
require_relative 'states/base_state'
require_relative 'states/console_state'
require_relative 'states/menu_state'
require_relative 'states/registration_state'
require_relative 'states/game_state'
require_relative 'context'
require_relative 'states/final_state'
