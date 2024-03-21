class Loop
  attr_accessor :start, :stop, :number

  # start and stop is relative to the start
  def initialize(number, start:, stop:)
    @number = number
    @start = start
    @stop = stop
    @barkley_start = Barkley.start
  end

  def start
    @start&.duration
  end

  def stop
    @stop&.duration
  end

  def started? = state == :started
  def finished? = state == :finished
  def not_started? = state == :not_started
  def dnf? = state == :dnf
  def started_at = @barkley_start + @start.duration
  def finished_at = @barkley_start + @stop.duration

  def start_source = @start.source
  def finish_source = @stop.source

  def seconds_since_start(now = Time.now)
    now - @barkley_start - @start.duration
  end

  def state
    return :dnf if @stop && @stop.dnf?
    return :finished if @stop
    return :started if @start

    :not_started
  end

  # Get a score for a loop, so we can order who is in the lead
  def score
    points = 0.0
    # If you started you get a thousand points (if you finished, you
    # also started even if we don't have the numbers)
    points += 1000 if started? || finished?
    # Finishing is a thousand points
    points += 1000 if finished?
    # The higher the start time of the loop, the less points you
    # should get
    points += 1000.0/(start > 0 ? start : 1) if started?
    # Each loop is harder, so more points
    number * points
  end
end

t = ->(id) { "https://twitter.com/keithdunn/status/#{id}" }

# Each start and stop should be an instance of an Update, that's why
# the `U` lambda is there, so you just do `U["21:13:34"]`, which just
# wraps the string and makes it easier to deal withy later on.
#
# The real magic sauce is in providing the source URL as well, this
# way we can link back to it, the text would be a step further and
# also add the text of the tweet, so you don't even need to click
# through, but that's for when the kids are in bed.
#
U = -> (time, source = nil, text = nil) { Update.new(time, source, text) }

class Update
  attr_reader :source, :text
  def initialize(time, source, text)
    @time = time
    @source = source
    @text = text
  end

  def dnf? = @time == "DNF"
  def duration
    seconds, minutes, hours = @time.split(":").reverse

    (hours.to_i * 60 * 60) + (minutes.to_i * 60) + seconds.to_i
  end
end

data = {
  # Guessing like no tomorrow
  # john
  runner_1: [
    Loop.new(1, start: U["00:00:00"], stop: U["08:30:59"]),
    Loop.new(2, start: U["08:38:38"], stop: U["19:27:49"]),
    Loop.new(3, start: U["19:45:51"], stop: U["31:36:57", t["1770856700179788154"]]),
    Loop.new(4,
             start: U["31:48:36", t[1770873027825139776]],
             stop: nil),
    Loop.new(5, start: nil, stop: nil),
  ],
  # damian
  runner_2: [
    Loop.new(1, start: U["00:00:00"], stop: U["08:30:59"]),
    Loop.new(2, start: nil, stop: U["19:27:51"]),
    Loop.new(3, start: U["19:45:51"], stop: U["31:36:58", t["1770856700179788154"]]),
    Loop.new(4, start: U["31:50:19", t[1770873027825139776]], stop: nil),
    Loop.new(5, start: nil, stop: nil),
  ],
  # jasmin
  runner_3: [
    Loop.new(1, start: U["00:00:00"], stop: U["08:30:59"]),
    Loop.new(2, start: nil, stop: U["19:27:52"]),
    Loop.new(3, start: U["19:45:51"], stop: U["32:15:53", t[1770866384513249421]]),
    Loop.new(4, start: U["32:27:50", t[1770869408589574173]], stop: nil),
    Loop.new(5, start: nil, stop: nil),
  ],
  # Guessing because we only know that these came in a  few moments after the first three
  # sebastien
  more_1: [
    Loop.new(1, start: U["00:00:00"], stop: U["08:31:59"]),
    Loop.new(2, start: nil, stop: U["19:27:53"]),
    Loop.new(3, start: U["20:10:14"], stop: U["32:57:06", t[1770876876958912672]]),
    Loop.new(4, start: U["33:16:52", t[1770881998464118928]], stop: nil),
    Loop.new(5, start: nil, stop: nil),
  ],
  # ihor
  more_2: [
    Loop.new(1, start: U["00:00:00"], stop: U["08:31:59"]),
    Loop.new(2, start: nil, stop: U["19:27:54"]),
    Loop.new(3, start: U["19:45:51"], stop: U["31:31:47"]),
    Loop.new(4, start: U["31:46:21",t[1770859105072107625]], stop: nil),
    Loop.new(5, start: nil, stop: nil),
  ],
  more_3: [
    Loop.new(1, start: U["00:00:00"], stop: U["08:31:59"]),
    Loop.new(2, start: nil, stop: U["DNF"]),
    Loop.new(3, start: nil, stop: nil),
    Loop.new(4, start: nil, stop: nil),
    Loop.new(5, start: nil, stop: nil),
  ],
  # Greig
  next_1: [
    Loop.new(1, start: U["00:00:00"], stop: U["08:34:47"]),
    Loop.new(2, start: nil, stop: U["19:52:36"]),
    Loop.new(3, start: nil, stop: U["32:12:43", t[1770865783683367040]]),
    Loop.new(4, start: U["32:43:11", t[1770873749065043996]], stop: nil),
    Loop.new(5, start: nil, stop: nil),
  ],
  next_2: [
    Loop.new(1, start: U["00:00:00"], stop: U["08:35:17"]),
    Loop.new(2, start: nil, stop: nil),
    Loop.new(3, start: nil, stop: nil),
    Loop.new(4, start: nil, stop: nil),
    Loop.new(5, start: nil, stop: nil),
  ],
  # A guy with very daring shorts has finished loop one in 9:30:24. #BM100
  # A guy with very daring shorts started loop two at 9:55:02. #BM100
  # thomas
  very_daring_shorts: [
    Loop.new(1, start: U["00:00:00"], stop: U["09:30:24"]),
    Loop.new(2, start: U["09:55:02"], stop: U["22:08:57"]),
    Loop.new(3, start: U["23:55:00"], stop: nil),
    Loop.new(4, start: nil, stop: nil),
    Loop.new(5, start: nil, stop: nil),
  ],
  # followed by a nondescript guy in 8:46:35. #BM100
  # Jared
  non_descript_guy: [
    Loop.new(1, start: U["00:00:00"], stop: U["08:46:35"]),
    Loop.new(2, start: nil, stop: U["19:52:47"]),
    Loop.new(3, start: nil, stop: U["32:20:54", t[1770868051476390033]]),
    Loop.new(4, start: U["32:43:37", t[1770873749065043996]], stop: nil),
    Loop.new(5, start: nil, stop: nil),
  ],
  # A guy with awesome glasses has finished loop one in 9:16:14. #BM100
  # A guy with awesome glasses has begun loop two at 9:45:04. #BM100
  # albert
  guy_with_awesome_glasses: [
    Loop.new(1, start: U["00:00:00"], stop: U["09:16:14"]),
    Loop.new(2, start: U["09:45:04"], stop: U["20:26:04"]),
    Loop.new(3, start: U["21:08:52"], stop: U["33:22:37", t[1770883341241213218]]),
    Loop.new(4, start: U["33:49:19", t[1770889923660284332]], stop: nil),
    Loop.new(5, start: nil, stop: nil),
  ],
  # A Japanese runner has set a new personal record for loop one at 9:11:05. #BM100
  # tomokazu
  japanese_runner: [
    Loop.new(1, start: U["00:00:00"], stop: U["09:11:05"]),
    Loop.new(2, start: nil, stop: U["22:08:53"]),
    Loop.new(3, start: U["22:25:10"], stop: nil),
    Loop.new(4, start: nil, stop: nil),
    Loop.new(5, start: nil, stop: nil),
  ],
  # Two French runners have finished loop one in 8:45:48 and a few seconds later,
  # aurelien
  french_runner_1: [
    Loop.new(1, start: U["00:00:00"], stop: U["08:45:48"]),
    Loop.new(2, start: nil, stop: U["19:52:48"]),
    Loop.new(3, start: U["21:01:40"], stop: U["DNF"]),
    Loop.new(4, start: nil, stop: nil),
    Loop.new(5, start: nil, stop: nil),
  ],
  # maxime
  french_runner_2: [
    Loop.new(1, start: U["00:00:00"], stop: U["08:45:55"]),
    Loop.new(2, start: nil, stop: U["20:26:20"]),
    Loop.new(3, start: U["21:50:45"], stop: nil),
    Loop.new(4, start: nil, stop: nil),
    Loop.new(5, start: nil, stop: nil),
  ],
  # A guy with a gray beard and a muscular guy with tree trunk legs came through the fire tower at 12:55. #BM100
  guy_with_gray_beard: [
    Loop.new(1, start: U["00:00:00"], stop: nil),
    Loop.new(2, start: nil, stop: nil),
    Loop.new(3, start: nil, stop: nil),
    Loop.new(4, start: nil, stop: nil),
    Loop.new(5, start: nil, stop: nil),
  ],
  muscular_guy: [
    Loop.new(1, start: U["00:00:00"], stop: nil),
    Loop.new(2, start: nil, stop: nil),
    Loop.new(3, start: nil, stop: nil),
    Loop.new(4, start: nil, stop: nil),
    Loop.new(5, start: nil, stop: nil),
  ],
  # Guy with red hat finished loop one in 10:27:41, almost an hour behind the previous loop one finisher. #BM100
  guy_with_red_hat: [
    Loop.new(1, start: U["00:00:00"], stop: U["10:27:41"]),
    Loop.new(2, start: nil, stop: U["DNF"]),
    Loop.new(3, start: nil, stop: nil),
    Loop.new(4, start: nil, stop: nil),
    Loop.new(5, start: nil, stop: nil),
  ],
  # Another large gap, and the next loop one finisher comes in at 11:16:42. “Ratjaw sucks.” #BM100
  ratjaw_sucks: [
    Loop.new(1, start: U["00:00:00"], stop: U["11:16:42"]),
    Loop.new(2, start: nil, stop: nil),
    Loop.new(3, start: nil, stop: nil),
    Loop.new(4, start: nil, stop: nil),
    Loop.new(5, start: nil, stop: nil),
  ],
  # The next runner finishes loop one in 11:30; as he approaches the gate his crew yells “c’mon c’mon; we don’t have all day!”
  does_not_have_all_day: [
    Loop.new(1, start: U["00:00:00"], stop: U["11:30:00"]),
    Loop.new(2, start: nil, stop: nil),
    Loop.new(3, start: nil, stop: nil),
    Loop.new(4, start: nil, stop: nil),
    Loop.new(5, start: nil, stop: nil),
  ],
  # The man in black has finished loop one in 11:49:30. #BM100
  man_in_black: [
    Loop.new(1, start: U["00:00:00"], stop: U["11:49:30"]),
    Loop.new(2, start: U["11:57:04"], stop: U["DNF"]),
    Loop.new(3, start: nil, stop: nil),
    Loop.new(4, start: nil, stop: nil),
    Loop.new(5, start: nil, stop: nil),
  ],
  # The man in black begins loop two at 11:57:04. Eight minute interloopal period. MIB II finishes loop one immediately thereafter. #BM100
  man_in_black_2: [
    Loop.new(1, start: U["00:00:00"], stop: U["11:58:00"]),
    Loop.new(2, start: nil, stop: nil),
    Loop.new(3, start: nil, stop: nil),
    Loop.new(4, start: nil, stop: nil),
    Loop.new(5, start: nil, stop: nil),
  ],
  went_back_for_a_page: [
    Loop.new(1, start: U["00:00:00"], stop: U["11:30:00"]),
    Loop.new(2, start: nil, stop: U["26:25:29"]),
    Loop.new(3, start: U["26:27:00"], stop: nil),
    Loop.new(4, start: nil, stop: nil),
    Loop.new(5, start: nil, stop: nil),
  ],
}

# harvey
aliases = {
  # First three runners
  runner_1:                  :john,
  runner_2:                  :damian,
  runner_3:                  :jasmin,
  # 3 more runners
  more_1:                    :sebastien,
  more_2:                    :ihor,
  more_3: :harvey,
  # Next 2 runners
  next_1:                    :greig,
  next_2: nil,
  very_daring_shorts:        :thomas,
  non_descript_guy:          :jared,
  guy_with_awesome_glasses:  :albert,
  japanese_runner:           :tomokazu,
  french_runner_1:           :aurelien,
  french_runner_2:           :maxime,
  guy_with_gray_beard:       :christophe,
  muscular_guy: nil,
  guy_with_red_hat:          :hendrik,
  # Another large gap, and the next loop one finisher comes in at 11:16:42. “Ratjaw sucks.” #BM100
  ratjaw_sucks: nil,
  # The next runner finishes loop one in 11:30; as he approaches the gate his crew yells “c’mon c’mon; we don’t have all day!”
  does_not_have_all_day: nil,
  # The man in black has finished loop one in 11:49:30. #BM100
  man_in_black:             :harald,
  # The man in black begins loop two at 11:57:04. Eight minute interloopal period. MIB II finishes loop one immediately thereafter. #BM100
  man_in_black_2: nil,
  went_back_for_a_page: :guillaume,
}

aliases.each do |nickname, key|
  Barkley.loops ||= {}
  loops = data.fetch(nickname)

  runner = nil
  if key
    runner = Barkley.runners.find!(key)
    runner.nick_name = nickname
    runner.loops = loops
  end
  Barkley.loops[nickname] = [runner, loops]
end
