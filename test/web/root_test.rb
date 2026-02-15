# frozen_string_literal: true
require_relative 'test_helper'

class RootTest < WebTest

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

  describe '/' do
    it "should " do
      visit '/'
      assert_equal 200, page.status_code
    end

    it "loops" do
      visit '/loops'
      assert_equal 200, page.status_code
    end
  end

  [
    "2026",
    "2025",
    "2024",
  ].each do |year|
    describe year do
      describe '/#{year}' do
        it "should " do
          visit "/#{year}"
          assert_equal 200, page.status_code
        end
      end

      describe "/#{year}/loops" do
        it "works" do
          visit "/#{year}/loops"

          assert_equal 200, page.status_code
        end
      end
    end
  end
end
