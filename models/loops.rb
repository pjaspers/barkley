class Loop
  attr_accessor :number
  attr_reader :direction

  # start and stop is relative to the start
  def initialize(number, start:, stop:, direction: "CW")
    @number = number
    @start = start
    @stop = stop
    @barkley_start = Barkley.start
    @direction = direction
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

  def fun_run?
    return false unless number == 3
    return false unless finished?

    @stop.duration < 40*60*60
  end

  def start_source = @start.source
  def finish_source = @stop.source
  def start_title = @start&.text
  def stop_title = @stop&.text

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

tweets = {
  1770708985655488907 => "Aurélien Sanchez Began loop 3 at 21:50:45. #BM100",
  1770714062726295722 => "Tomo Ihara and Thomas Dunkerbeck finished loop two in  22:08:53, :57. #BM100",
  1770713123202208234 => "Aurélien Sanchez dropped on loop three and was tapped out. #BM100",
  1770718152688648536 => "Tomo began loop three at 22:25:10. #BM100",
  1770725093104091160 => "Harald Zundel dropped after getting lost on loop two and ending up knocking on someone’s door looking for help. #BM100",
  1770744084581187872 => "Kelly Halpin, Harvey Lewis, Hendrik Boury, and Nicolay Nachev came in together after dropping on loop two and are tapped out. #BM100",
  1770781038903460322 => "Guillaume Calmettes finished loop two in 26:25:29, turned it around quickly at the gate, and began loop three with about three minutes to spare. #BM100",
  1770855514294952031 => "Ihor Verys has finished loop three in 31:31:47. #BM100",
  1770856700179788154 => "John Kelly and Damian Hall finished loop three in 31:36:57, :58. #BM100",
  1770873027825139776 => "Ok, to correct a couple numbers - John Kelly began loop four at 31:48:36; Damian Hall began loop four at 31:50:19. #BM100",
  1770866384513249421 => "Jasmin Paris finished loop three in 32:15:53, smiling and looking good. #BM100",
  1770869408589574173 => "Jasmin Paris began loop four at 32:27:50. #BM100",
  1770876876958912672 => "Sebastien Raichon finished loop three in 32:57:06. #BM100",
  1770881998464118928 => "Sebastien Raichon began loop four at 33:16:52. #BM100",
  1770859105072107625 => "Ihor Verys began loop four at 31:46:21. #BM100",
  1770865783683367040 => "Greig Hamilton finished loop three in 32:12:43. #BM100",
  1770873749065043996 => "Greig Hamilton began loop four at 32:43:11 and Jared Campbell began loop 4 at 32:43:37. #BM100",
  1770868051476390033 => "Jared Campbell finished loop three in 32:20:54. #BM100",
  1770883341241213218 => "Albert Herrero Casas finished loop three in 33:22:37. #BM100",
  1770889923660284332 => "Albert Herrero Casas began loop four at 33:49:19. #BM100",
  1770901120396742981 => "Maxime Gauduin finished loop three in 34:32:49. #BM100",
  1770903945910636768 => "Tomo Ihara finished loop three in 34:43:15. #BM100",
  1770909152694440019 => "Tomo began loop four at 35:04:16. #BM100",
  1770920536987566265 => "Maxime Gauduin began loop four at 35:59:26. Ten runners are on loop four. #BM100",
  1770926893753115028 => "Thomas Dunkerbeck finished loop three in 36:15:40. #BM100",
  1771070767406432602 => "John Kelly and Ihor Verys finished loop four in 45:46:32, :36 #BM100",
  1771075652847894917 => "Ihor Verys began loop five at 46:06:32. He chose to go clockwise. #BM100",
  1771078341887459742 => "Greig Hamilton and Damian Hall finished loop four in 46:15:43 and 46:16:27. #BM100",
  1771078702408823196 => "Jared Campbell finished loop four in 46:19:25. #BM100",
  1771081701755637895 => "John Kelly began loop five in the counter-clockwise direction; Damian Hall  is going clockwise, Greig Hamilton is going counter-clockwise. #BM100",
  1771081868370223302 => "Jasmin Paris finished loop four in 46:29:12. #BM100",
  1771088295067279399 => "Tomo Ihara dropped on loop four, taking quitter’s road back to camp. #BM100",
  1771090354835521860 => "Albert Herrero Casas also came back to camp via quitter’s road and was tapped out. #BM100",
  1771085327395958831 => "Jasmin Paris @JasminKParis
 has started loop five in the clockwise direction, while Jared Campbell @derajslc
 is going counter-clockwise.  #BM100",
 1771026334849851730 => "Maxime Gauduin dropped on loop four at Fire Tower and is tapped out. “It’s really different from the BFC.”  #BM100",
 1770981623212749291 => "Guillaume Calmettes @gcalmettes
 finished loop three in 39:52:59.  #BM100",
 1771100559249993856 => "Sebastien Raichon appeared to have finished loop four, but failed to follow the course near the end of the loop.  After correcting his error he finished the loop in 47:45:39. #BM100",
 1771103254971035821 => "Sebastien Raichon began loop five, three minutes before the cutoff. For the first time ever, seven runners are on loop five at the #BM100.",
}

t = ->(id) { ["https://twitter.com/keithdunn/status/#{id}", tweets[id]] }

# Each start and stop should be an instance of an Update, that's why
# the `U` lambda is there, so you just do `U["21:13:34"]`, which just
# wraps the string and makes it easier to deal withy later on.
#
# The real magic sauce is in providing the source URL as well, this
# way we can link back to it, the text would be a step further and
# also add the text of the tweet, so you don't even need to click
# through, but that's for when the kids are in bed.
#
U = -> (time, tweet = []) { Update.new(time, tweet[0], tweet[1]) }

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
             stop: U["45:46:32", t[1771070767406432602]]),
    Loop.new(5, start: U["46:22:00", t[1771081701755637895]], stop: nil, direction: :ccw),
  ],
  # damian
  runner_2: [
    Loop.new(1, start: U["00:00:00"], stop: U["08:30:59"]),
    Loop.new(2, start: nil, stop: U["19:27:51"]),
    Loop.new(3, start: U["19:45:51"], stop: U["31:36:58", t["1770856700179788154"]]),
    Loop.new(4, start: U["31:50:19", t[1770873027825139776]], stop: U["46:16:27", t[1771078341887459742]]),
    Loop.new(5, start: U["46:22:00", t[1771081701755637895]], stop: nil, direction: :cw),
  ],
  # jasmin
  runner_3: [
    Loop.new(1, start: U["00:00:00"], stop: U["08:30:59"]),
    Loop.new(2, start: nil, stop: U["19:27:52"]),
    Loop.new(3, start: U["19:45:51"], stop: U["32:15:53", t[1770866384513249421]]),
    Loop.new(4, start: U["32:27:50", t[1770869408589574173]], stop: U["46:29:12", t[1771081868370223302]]),
    Loop.new(5, start: U["46:41:00", t[1771085327395958831]], stop: nil, direction: :cw),
  ],
  # Guessing because we only know that these came in a  few moments after the first three
  # sebastien
  more_1: [
    Loop.new(1, start: U["00:00:00"], stop: U["08:31:59"]),
    Loop.new(2, start: nil, stop: U["19:27:53"]),
    Loop.new(3, start: U["20:10:14"], stop: U["32:57:06", t[1770876876958912672]]),
    Loop.new(4, start: U["33:16:52", t[1770881998464118928]], stop: U["47:45:39", t[1771100559249993856]]),
    Loop.new(5, start: U["47:57:00", t[1771103254971035821]], stop: nil, direction: :cw),
  ],
  # ihor
  more_2: [
    Loop.new(1, start: U["00:00:00"], stop: U["08:31:59"]),
    Loop.new(2, start: nil, stop: U["19:27:54"]),
    Loop.new(3, start: U["19:45:51"], stop: U["31:31:47", t[1770855514294952031]]),
    Loop.new(4, start: U["31:46:21",t[1770859105072107625]], stop: U["45:46:36", t[1771070767406432602]]),
    Loop.new(5, start: U["46:06:32", t[1771075652847894917]], stop: nil, direction: :cw),
  ],
  more_3: [
    Loop.new(1, start: U["00:00:00"], stop: U["08:31:59"]),
    Loop.new(2, start: nil, stop: U["DNF", t[1770744084581187872]]),
    Loop.new(3, start: nil, stop: nil),
    Loop.new(4, start: nil, stop: nil),
    Loop.new(5, start: nil, stop: nil),
  ],
  # Greig
  next_1: [
    Loop.new(1, start: U["00:00:00"], stop: U["08:34:47"]),
    Loop.new(2, start: nil, stop: U["19:52:36"]),
    Loop.new(3, start: nil, stop: U["32:12:43", t[1770865783683367040]]),
    Loop.new(4, start: U["32:43:11", t[1770873749065043996]], stop: U["46:15:43", t[1771078341887459742]]),
    Loop.new(5, start: U["46:22:00", t[1771081701755637895]], stop: nil, direction: :ccw),
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
    Loop.new(2, start: U["09:55:02"], stop: U["22:08:57", t[1770714062726295722]]),
    Loop.new(3, start: U["23:55:00"], stop: U["36:15:40", t[1770926893753115028]]),
    Loop.new(4, start: nil, stop: nil),
    Loop.new(5, start: nil, stop: nil),
  ],
  # followed by a nondescript guy in 8:46:35. #BM100
  # Jared
  non_descript_guy: [
    Loop.new(1, start: U["00:00:00"], stop: U["08:46:35"]),
    Loop.new(2, start: nil, stop: U["19:52:47"]),
    Loop.new(3, start: nil, stop: U["32:20:54", t[1770868051476390033]]),
    Loop.new(4, start: U["32:43:37", t[1770873749065043996]], stop: U["46:19:25", t[1771078702408823196]]),
    Loop.new(5, start: U["46:41:00", t[1771085327395958831]], stop: nil, direction: :ccw),
  ],
  # A guy with awesome glasses has finished loop one in 9:16:14. #BM100
  # A guy with awesome glasses has begun loop two at 9:45:04. #BM100
  # albert
  guy_with_awesome_glasses: [
    Loop.new(1, start: U["00:00:00"], stop: U["09:16:14"]),
    Loop.new(2, start: U["09:45:04"], stop: U["20:26:04"]),
    Loop.new(3, start: U["21:08:52"], stop: U["33:22:37", t[1770883341241213218]]),
    Loop.new(4, start: U["33:49:19", t[1770889923660284332]], stop: U["DNF", t[1771090354835521860]]),
    Loop.new(5, start: nil, stop: nil),
  ],
  # A Japanese runner has set a new personal record for loop one at 9:11:05. #BM100
  # tomokazu
  japanese_runner: [
    Loop.new(1, start: U["00:00:00"], stop: U["09:11:05"]),
    Loop.new(2, start: nil, stop: U["22:08:53", t[1770714062726295722]]),
    Loop.new(3, start: U["22:25:10", t[1770718152688648536]], stop: U["34:43:15", t[1770903945910636768]]),
    Loop.new(4, start: U["35:04:16", t[1770909152694440019]], stop: U["DNF", t[1771088295067279399]]),
    Loop.new(5, start: nil, stop: nil),
  ],
  # Two French runners have finished loop one in 8:45:48 and a few seconds later,
  # aurelien
  french_runner_1: [
    Loop.new(1, start: U["00:00:00"], stop: U["08:45:48"]),
    Loop.new(2, start: nil, stop: U["19:52:48"]),
    Loop.new(3, start: U["21:01:40", t[1770708985655488907]], stop: U["DNF", t[1770713123202208234]]),
    Loop.new(4, start: nil, stop: nil),
    Loop.new(5, start: nil, stop: nil),
  ],
  # maxime
  french_runner_2: [
    Loop.new(1, start: U["00:00:00"], stop: U["08:45:55"]),
    Loop.new(2, start: nil, stop: U["20:26:20"]),
    Loop.new(3, start: U["21:50:45"], stop: U["34:32:49", t[1770901120396742981]]),
    Loop.new(4, start: U["35:59:26", t[1770920536987566265]], stop: U["DNF", t[1771026334849851730]]),
    Loop.new(5, start: nil, stop: nil),
  ],
  # A guy with a gray beard and a muscular guy with tree trunk legs came through the fire tower at 12:55. #BM100
  guy_with_gray_beard: [
    Loop.new(1, start: U["00:00:00"], stop: U["DNF", ["https://twitter.com/generalgoliath/status/1770810728397647988", "Had to drop after 5 hours, due to ankle injury. (Source: his Strava and Facebook)"]]),
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
    Loop.new(2, start: nil, stop: U["DNF", t[1770744084581187872]]),
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
    Loop.new(2, start: U["11:57:04"], stop: U["DNF", t[1770725093104091160]]),
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
    Loop.new(2, start: nil, stop: U["26:25:29", t[1770781038903460322]]),
    Loop.new(3, start: U["26:27:00", t[1770781038903460322]], stop: U["39:52:59", t[1770981623212749291]]),
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
