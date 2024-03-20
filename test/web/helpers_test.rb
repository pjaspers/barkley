# frozen_string_literal: true
require_relative 'test_helper'

class HelpersTest < WebTest
  it "humanize" do
    app = App.new({})

    assert_equal "11 minutes and 50 seconds", app.humanize(710)
    assert_equal "1 minute", app.humanize(60)
  end

  it "hour_minute_seconds" do
    app = App.new({})

    assert_equal [0,11,50], hour_minute_seconds(710)
  end
end
