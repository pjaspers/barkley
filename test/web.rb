# frozen_string_literal: true
ENV['NO_AUTOLOAD'] = '1'
Dir['./test/web/*_test.rb'].each{|f| require f}
