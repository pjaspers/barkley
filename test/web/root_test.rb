# frozen_string_literal: true
require_relative 'test_helper'

class RootTest < WebTest
  describe '/' do
    it "should " do
      visit '/'
      assert_equal 200, page.status_code
    end
  end

  describe "/r/<runner>" do
    Barkley.runners.each do |runner|
      it "works" do
        runner.slugs.each do |slug|
          visit "/r/#{slug}"

          assert_equal 200, page.status_code
        end
      end
    end
  end

  describe "/loops" do
    it "works" do
      visit "/loops"

      assert_equal 200, page.status_code
    end
  end
end
