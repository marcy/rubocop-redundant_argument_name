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

        def on_hash(node)
          node.pairs.each do |pair|
            key, value = pair.key, pair.value

            next unless key.value == value.node_parts[1]

            add_offense(pair, message: MSG) do |corrector|
              corrector.replace(pair, "#{key.value}:")
            end
          end
        end
      end
    end
  end
end
