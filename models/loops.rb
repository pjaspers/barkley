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

  def _start = @start
  def _stop = @stop

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
    points += 1000 if started? || finished? || dnf?
    # Finishing is a thousand points
    points += 1000 if finished?
    # The higher the start time of the loop, the less points you
    # should get
    points += number**2*1000.0/(start > 0 ? start : 1) if started?
    # And you should get points for finishing first
    points += number**2*1000.0/(stop > 0 ? stop : 1) if finished?
    # Each loop is harder, so more points
    number * points
  end
end

class Update
  attr_reader :source, :text, :time
  def initialize(time, source = nil, text = nil)
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
