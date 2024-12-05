# frozen_string_literal: true

require 'rubocop'

require_relative 'rubocop/redundant_argument_name'
require_relative 'rubocop/redundant_argument_name/version'
require_relative 'rubocop/redundant_argument_name/inject'

RuboCop::RedundantArgumentName::Inject.defaults!

require_relative 'rubocop/cop/redundant_argument_name_cops'
