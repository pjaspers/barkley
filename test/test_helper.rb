ENV['MT_NO_PLUGINS'] = '1' # Work around stupid autoloading of plugins
gem 'minitest'
require 'minitest/hooks/default'
require "minitest/autorun"
require "pathname"
ENV["RACK_ENV"] = "test"

class Test < Minitest::Test
  # Add spec DSL
  extend Minitest::Spec::DSL
  include Minitest::Hooks

  def around
    # DB.transaction(rollback: :always, savepoint: true, auto_savepoint: true) do
      super
      Mail::TestMailer.deliveries.clear if defined?(Mail)
    # end
  end

  def around_all
    # DB.transaction(rollback: :always, savepoint: true, auto_savepoint: true) do
      super
    # end
  end

  def log
    LOGGER.level = Logger::INFO
    yield
  ensure
    LOGGER.level = Logger::FATAL
  end
end

def root
  Pathname.new(File.expand_path("..", File.join(File.dirname(__FILE__))))
end

freeze_core = false # change to true to enable refrigerator
if freeze_core
  at_exit do
    require 'refrigerator'
    Refrigerator.freeze_core
  end
end
