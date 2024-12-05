# frozen_string_literal: true

module RuboCop
  module Cop
    module Style
      # bad
      # foo(bar: bar)
      # good
      # foo(bar:)
      class RedundantArgumentName < Base
        extend AutoCorrector

        MSG = 'Argument name can be omitted for brevity when it matches the parameter name.'

        def_node_matcher :hash_argument_with_redundancy?, <<~PATTERN
          (send _ _ (hash <(pair (sym $_) (send nil? $_)) ...>))
        PATTERN

        def on_send(node)
          hash_argument_with_redundancy?(node) do |key, value|
            next unless key == value

            add_offense(node) do |corrector|
              corrector.replace(node, corrected_code(node, key))
            end
          end
        end

        private

        def corrected_code(node, redundant_key)
          node.source.gsub(/#{redundant_key}:\s*#{redundant_key}/, "#{redundant_key}:")
        end
      end
    end
  end
end
