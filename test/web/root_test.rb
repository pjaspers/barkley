# frozen_string_literal: true
require_relative 'test_helper'

class RootTest < WebTest
  describe "2026" do
    describe '/' do
      it "should " do
        visit '/'
        assert_equal 200, page.status_code
      end
    end

    describe "/r/<runner>" do
      Barkley::Edition.for_year(2026).runners.each do |runner|
        it "works" do
          runner.slugs.each do |slug|
            visit "/2026/r/#{slug}"

            assert_equal 200, page.status_code
          end
        end
      end
    end
  end

  describe "2025" do
    describe '/' do
      it "should " do
        visit '/2025'
        assert_equal 200, page.status_code
      end
    end

    describe "/r/<runner>" do
      Barkley::Edition.for_year(2025).runners.each do |runner|
        it "works" do
          runner.slugs.each do |slug|
            visit "/2025/r/#{slug}"

            assert_equal 200, page.status_code
          end
        end
      end
    end

    describe "/loops" do
      it "works" do
        visit "/2025/loops"

        assert_equal 200, page.status_code
      end
    end
  end

  describe "2024" do
    it "/2024" do
      visit '/2024'
      assert_equal 200, page.status_code
    end

    describe "/r/<runner>" do
      Barkley::Edition.for_year(2024).runners.each do |runner|
        it "works" do
          runner.slugs.each do |slug|
            visit "/2024/r/#{slug}"

            assert_equal 200, page.status_code
          end
        end
      end
    end

    describe "/loops" do
      it "works" do
        visit "/2024/loops"

        assert_equal 200, page.status_code
      end
    end
  end
end
