require_relative "./update"

class Loop
  attr_accessor :number
  attr_reader :direction

  def self.from_data(data, barkley_start:)
    start = data[:start]
    if start[:time]
      start_update = Update.new(start[:time], start[:source], start[:text])
    end
    stop = data[:stop]
    if stop[:time]
      stop_update = Update.new(stop[:time], stop[:source], stop[:text])
    end

    Loop.new(data[:index],
             start: start_update,
             stop: stop_update,
             barkley_start: barkley_start,
             direction: data[:direction])
  end

  # start and stop is relative to the start
  def initialize(number, start:, stop:, barkley_start:, direction: "CW")
    @number = number
    @start = start
    @stop = stop
    @barkley_start = barkley_start
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
    if started?
      points += number**2*1000.0/start
    end
    # And you should get points for finishing first
    if finished?
      points += number**2*1000.0/stop
    end
    # Each loop is harder, so more points
    number * points
  end
end
