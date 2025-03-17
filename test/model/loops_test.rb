require_relative 'test_helper'

class LoopsTest < Test

  before do
    @edition = Barkley::Edition.for_year(2024)
  end

  it "started" do
    loop = Loop.new(1, start: Update.new("08:32:33"), stop: nil, barkley_start: @edition.start)

    assert loop.started?
    assert_nil loop.start_title
    assert_nil loop.stop
    assert_nil loop.stop_title
  end

  it "finished" do
    loop = Loop.new(1, start: Update.new("08:32:33"), stop: Update.new("20:10:06"), barkley_start: @edition.start)

    assert loop.finished?
  end

  it "not_started" do
    loop = Loop.new(1, start: nil, stop: nil, barkley_start: @edition.start)

    assert loop.not_started?
    assert_nil loop.start_title
  end

  it "has seconds since start" do
    time = Time.now
    loop = Loop.new(1, start: Update.new("01:00:00"), stop: Update.new("20:10:06"), barkley_start: time - 2*60*60)

    # Barkley started an hour ago, 1 hour was passed in the loop
    assert_equal 3600, loop.seconds_since_start(time)
  end

  it "score" do
    first_loop = Loop.new(1, start: Update.new("08:32:33"), stop: nil, barkley_start: @edition.start)
    last_loop = Loop.new(5, start: Update.new("15:32:33"), stop: nil, barkley_start: @edition.start)
    assert first_loop.score < last_loop.score
  end
end
