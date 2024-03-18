require_relative 'test_helper'

class LoopsTest < Test
  it "started" do
    loop = Loop.new(1, start: "08:32:33", stop: nil)

    assert_equal :started, loop.state
  end

  it "finished" do
    loop = Loop.new(1, start: "08:32:33", stop: "20:10:06")

    assert_equal :finished, loop.state
  end

  it "not_started" do
    loop = Loop.new(1, start: nil, stop: nil)

    assert_equal :not_started, loop.state
  end
end
