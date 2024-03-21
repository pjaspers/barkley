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

    assert_equal [0,11,50], app.hour_minute_seconds(710)
    assert_equal "00:11:50", app.hhmmss(710)
  end

  it "over 24 hours" do
    app = App.new({})

    assert_equal [28,45,20], app.hour_minute_seconds(28*60*60 + 45*60 + 20)
  end
end
