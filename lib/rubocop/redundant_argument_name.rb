# frozen_string_literal: true

require_relative "redundant_argument_name/version"
require_relative "cop/style/redundant_argument_name"

module RuboCop
  module RedundantArgumentName
    class Error < StandardError; end
    # Your code goes here...
    PROJECT_ROOT   = Pathname.new(__dir__).parent.parent.expand_path.freeze
    CONFIG_DEFAULT = PROJECT_ROOT.join('config', 'default.yml').freeze
    CONFIG         = YAML.safe_load(CONFIG_DEFAULT.read).freeze

    private_constant(:CONFIG_DEFAULT, :PROJECT_ROOT)
  end
end

