# frozen_string_literal: true
ENV['NO_AUTOLOAD'] = '1'
Dir['./test/model/*_test.rb'].each{|f| require f}
