# frozen_string_literal: true
require 'pry'
# TODO: when finished, run `rake generate_cops_documentation` to update the docs
module RuboCop
  module Cop
    module FactoryBotExtension
      # TODO: Write cop description and example of bad / good code. For every
      # `SupportedStyle` and unique configuration, there needs to be examples.
      # Examples must have valid Ruby syntax. Do not use upticks.
      #
      # @example EnforcedStyle: bar (default)
      #   # Description of the `bar` style.
      #
      #   # bad
      #   bad_bar_method
      #
      #   # bad
      #   bad_bar_method(args)
      #
      #   # good
      #   good_bar_method
      #
      #   # good
      #   good_bar_method(args)
      #
      # @example EnforcedStyle: foo
      #   # Description of the `foo` style.
      #
      #   # bad
      #   bad_foo_method
      #
      #   # bad
      #   bad_foo_method(args)
      #
      #   # good
      #   good_foo_method
      #
      #   # good
      #   good_foo_method(args)
      #
      class CreateAssociationInHook < Cop
        # TODO: Implement the cop in here.
        #
        # In many cases, you can use a node matcher for matching node pattern.
        # See https://github.com/rubocop-hq/rubocop/blob/master/lib/rubocop/node_pattern.rb
        #
        # For example
        MSG = 'Create association records in hooks inside `trait { ... }`'

        def_node_matcher :bad_method?, <<~PATTERN
          (send nil? :bad_method ...)
        PATTERN

        def on_send(node)
          return if node.method_name != :create && node.method_name != :build
          binding.pry
          if (node.parent.method_name == :after || node.parent.method_name == :before) && node.parent.parent.method_name != :trait
            add_offense(node)
          end
        end
      end
    end
  end
end
