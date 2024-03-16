# frozen_string_literal: true
ENV["RACK_ENV"] = "test"
require_relative '../coverage_helper'
require_relative '../../models'
raise "test database doesn't end with test" unless DB_PATH.end_with?('_test.db')

require_relative '../test_helper'

if ENV['NO_AUTOLOAD']
  Sequel::Model.freeze_descendents
  DB.freeze
end
