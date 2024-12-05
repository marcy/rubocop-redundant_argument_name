# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Style::RedundantArgumentName, :config do
  context 'when hash name matches local variable' do
    it 'registers an offense and corrects it' do
      expect_offense(<<~RUBY)
        {foo: foo}
         ^^^^^^^^ Argument name can be omitted for brevity when it matches the parameter name.
      RUBY

      expect_correction(<<~RUBY)
        {foo:}
      RUBY
    end
  end

  context 'when argument name matches local variable' do
    it 'registers an offense and corrects it' do
      expect_offense(<<~RUBY)
        fun(foo: foo)
            ^^^^^^^^ Argument name can be omitted for brevity when it matches the parameter name.
      RUBY

      expect_correction(<<~RUBY)
        fun(foo:)
      RUBY
    end
  end

  context 'when argument name does not match local variable' do
    it 'does not register an offense' do
      expect_no_offenses(<<~RUBY)
        fun(foo: bar)
      RUBY
    end
  end

  context 'when there are multiple arguments and some are redundant' do
    it 'registers an offense only for the redundant arguments and corrects them' do
      expect_offense(<<~RUBY)
        fun(foo: foo, bar: baz)
            ^^^^^^^^ Argument name can be omitted for brevity when it matches the parameter name.
      RUBY

      expect_correction(<<~RUBY)
        fun(foo:, bar: baz)
      RUBY
    end
  end

  context 'when no arguments are passed' do
    it 'does not register an offense' do
      expect_no_offenses(<<~RUBY)
        fun()
      RUBY
    end
  end

  context 'when argument is a method call' do
    it 'does not register an offense' do
      expect_no_offenses(<<~RUBY)
        fun(foo: some_method)
      RUBY
    end
  end

  context 'when argument is a literal' do
    it 'does not register an offense' do
      expect_no_offenses(<<~RUBY)
        fun(foo: 42)
      RUBY
    end
  end
end
