class Loop
  attr_accessor :start, :stop, :number

  # start and stop is relative to the start
  def initialize(number, start:, stop:)
    @number = number
    @start = start ? duration_to_sec(start) : start
    @stop = stop ? duration_to_sec(stop) : stop
    @barkley_start = Barkley.start
  end

  def started? = state == :started
  def finished? = state == :finished?
  def not_started? = state == :not_started?
  def started_at = @barkley_start + @start
  def finished_at = @barkley_start + @stop

  def seconds_since_start(now = Time.now)
    now - @barkley_start - @start
  end

  def state
    return :finished if @stop
    return :started if @start

    :not_started
  end

  private def duration_to_sec(duration)
    seconds, minutes, hours = duration.split(":").reverse

    (hours.to_i * 60 * 60) + (minutes.to_i * 60) + seconds.to_i
  end
end

data = {
  runner_1: [
    Loop.new(1, start: "00:00:00", stop: "08:30:59"),
    Loop.new(2, start: "08:38:38", stop: nil),
    Loop.new(3, start: nil, stop: nil),
    Loop.new(4, start: nil, stop: nil),
    Loop.new(5, start: nil, stop: nil),
  ],
  runner_2: [
    Loop.new(1, start: "00:00:00", stop: "08:30:59"),
    Loop.new(2, start: nil, stop: nil),
    Loop.new(3, start: nil, stop: nil),
    Loop.new(4, start: nil, stop: nil),
    Loop.new(5, start: nil, stop: nil),
  ],
  runner_3: [
    Loop.new(1, start: "00:00:00", stop: "08:30:59"),
    Loop.new(2, start: nil, stop: nil),
    Loop.new(3, start: nil, stop: nil),
    Loop.new(4, start: nil, stop: nil),
    Loop.new(5, start: nil, stop: nil),
  ],
  # Guessing because we only know that these came in a few moments after the first three
  more_1: [
    Loop.new(1, start: "00:00:00", stop: "08:31:59"),
    Loop.new(2, start: nil, stop: nil),
    Loop.new(3, start: nil, stop: nil),
    Loop.new(4, start: nil, stop: nil),
    Loop.new(5, start: nil, stop: nil),
  ],
  more_2: [
    Loop.new(1, start: "00:00:00", stop: "08:31:59"),
    Loop.new(2, start: nil, stop: nil),
    Loop.new(3, start: nil, stop: nil),
    Loop.new(4, start: nil, stop: nil),
    Loop.new(5, start: nil, stop: nil),
  ],
  more_3: [
    Loop.new(1, start: "00:00:00", stop: "08:31:59"),
    Loop.new(2, start: nil, stop: nil),
    Loop.new(3, start: nil, stop: nil),
    Loop.new(4, start: nil, stop: nil),
    Loop.new(5, start: nil, stop: nil),
  ],
  next_1: [
    Loop.new(1, start: "00:00:00", stop: "08:34:47"),
    Loop.new(2, start: nil, stop: nil),
    Loop.new(3, start: nil, stop: nil),
    Loop.new(4, start: nil, stop: nil),
    Loop.new(5, start: nil, stop: nil),
  ],
  next_2: [
    Loop.new(1, start: "00:00:00", stop: "08:35:17"),
    Loop.new(2, start: nil, stop: nil),
    Loop.new(3, start: nil, stop: nil),
    Loop.new(4, start: nil, stop: nil),
    Loop.new(5, start: nil, stop: nil),
  ],
  # A guy with very daring shorts has finished loop one in 9:30:24. #BM100
  # A guy with very daring shorts started loop two at 9:55:02. #BM100
  very_daring_shorts: [
    Loop.new(1, start: "00:00:00", stop: "09:30:24"),
    Loop.new(2, start: "09:55:02", stop: nil),
    Loop.new(3, start: nil, stop: nil),
    Loop.new(4, start: nil, stop: nil),
    Loop.new(5, start: nil, stop: nil),
  ],
  # followed by a nondescript guy in 8:46:35. #BM100
  non_descript_guy: [
    Loop.new(1, start: "00:00:00", stop: "08:46:35"),
    Loop.new(2, start: nil, stop: nil),
    Loop.new(3, start: nil, stop: nil),
    Loop.new(4, start: nil, stop: nil),
    Loop.new(5, start: nil, stop: nil),
  ],
  # A guy with awesome glasses has finished loop one in 9:16:14. #BM100
  # A guy with awesome glasses has begun loop two at 9:45:04. #BM100
  guy_with_awesome_glasses: [
    Loop.new(1, start: "00:00:00", stop: "09:16:14"),
    Loop.new(2, start: "09:45:04", stop: nil),
    Loop.new(3, start: nil, stop: nil),
    Loop.new(4, start: nil, stop: nil),
    Loop.new(5, start: nil, stop: nil),
  ],
  # A Japanese runner has set a new personal record for loop one at 9:11:05. #BM100
  japanese_runner: [
    Loop.new(1, start: "00:00:00", stop: "09:11:05"),
    Loop.new(2, start: nil, stop: nil),
    Loop.new(3, start: nil, stop: nil),
    Loop.new(4, start: nil, stop: nil),
    Loop.new(5, start: nil, stop: nil),
  ],
  # Two French runners have finished loop one in 8:45:48 and a few seconds later,
  french_runner_1: [
    Loop.new(1, start: "00:00:00", stop: "08:45:48"),
    Loop.new(2, start: nil, stop: nil),
    Loop.new(3, start: nil, stop: nil),
    Loop.new(4, start: nil, stop: nil),
    Loop.new(5, start: nil, stop: nil),
  ],
  french_runner_2: [
    Loop.new(1, start: "00:00:00", stop: "08:45:55"),
    Loop.new(2, start: nil, stop: nil),
    Loop.new(3, start: nil, stop: nil),
    Loop.new(4, start: nil, stop: nil),
    Loop.new(5, start: nil, stop: nil),
  ],
  # A guy with a gray beard and a muscular guy with tree trunk legs came through the fire tower at 12:55. #BM100
  guy_with_gray_beard: [
    Loop.new(1, start: "00:00:00", stop: nil),
    Loop.new(2, start: nil, stop: nil),
    Loop.new(3, start: nil, stop: nil),
    Loop.new(4, start: nil, stop: nil),
    Loop.new(5, start: nil, stop: nil),
  ],
  muscular_guy: [
    Loop.new(1, start: "00:00:00", stop: nil),
    Loop.new(2, start: nil, stop: nil),
    Loop.new(3, start: nil, stop: nil),
    Loop.new(4, start: nil, stop: nil),
    Loop.new(5, start: nil, stop: nil),
  ]
}

aliases = {
  # First three runners
  runner_1:                  :john,
  runner_2:                  :damian,
  runner_3:                  :harvey,
  # 3 more runners
  more_1: nil,
  more_2: nil,
  more_3: nil,
  # Next 2 runners
  next_1: nil,
  next_2: nil,
  very_daring_shorts:        :thomas,
  non_descript_guy:          :jared,
  guy_with_awesome_glasses:  :albert,
  japanese_runner:           :tomokazu,
  french_runner_1:           :aurelien,
  french_runner_2:           :maxime,
  guy_with_gray_beard:       :christophe,
  muscular_guy: nil,
}

aliases.each do |nickname, key|
  Barkley.loops ||= {}
  loops = data.fetch(nickname)

  Barkley.loops[nickname] = loops
  if key
    runner = Barkley.runners.find!(key)
    runner.nick_name = nickname
    runner.loops = loops
  end
end
