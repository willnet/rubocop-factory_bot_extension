# frozen_string_literal: true

require 'rubocop'

require_relative 'rubocop/factory_bot_extension'
require_relative 'rubocop/factory_bot_extionsion/version'
require_relative 'rubocop/factory_bot_extionsion/inject'

RuboCop::FactoryBotExtension::Inject.defaults!

require_relative 'rubocop/cop/factory_bot_extension_cops'
