# frozen_string_literal: true
ENV["RACK_ENV"] = "test"
require_relative '../coverage_helper'
require_relative '../test_helper'
require_relative '../../app'
Tilt.finalize!

require 'capybara'
require 'capybara/dsl'
require 'rack/test'

Gem.suffix_pattern

# App.plugin :error_handler do |e|
#   raise e
# end

App.freeze if ENV['NO_AUTOLOAD']
Capybara.app = App.app
Capybara.exact = true

class WebTest < Test
  include Rack::Test::Methods
  include Capybara::DSL

  def app
    Capybara.app
  end

  after do
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end
end
