# frozen_string_literal: true
require_relative 'test_helper'

class RootTest < WebTest
  describe '/' do
    it "should " do
      visit '/'
      assert_equal 200, page.status_code
    end
  end

  describe "/r/harvey" do
    it "works" do
      visit "/r/harvey"

      assert_equal 200, page.status_code
    end
  end

end
