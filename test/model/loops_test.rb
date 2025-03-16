require_relative 'test_helper'

class LoopsTest < Test
  it "started" do
    loop = Loop.new(1, start: Update.new("08:32:33"), stop: nil)

    assert loop.started?
  end

  it "finished" do
    loop = Loop.new(1, start: Update.new("08:32:33"), stop: Update.new("20:10:06"))

    assert loop.finished?
  end

  it "not_started" do
    loop = Loop.new(1, start: nil, stop: nil)

    assert loop.not_started?
  end

  it "has seconds since start" do
    time = Time.now
    Barkley.stub :start, time - 2*60*60 do
      loop = Loop.new(1, start: Update.new("01:00:00"), stop: Update.new("20:10:06"))

      # Barkley started an hour ago, 1 hour was passed in the loop
      assert_equal 3600, loop.seconds_since_start(time)
    end
  end
end
