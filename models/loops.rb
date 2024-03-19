class Loop
  # start and stop is relative to the start
  def initialize(number, start:, stop:)
    @number = number
    @start = start ? duration_to_sec(start) : start
    @stop = stop ? duration_to_sec(stop) : stop
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
  :albert => [
   Loop.new(1, start: nil, stop: nil),
   Loop.new(2, start: nil, stop: nil),
   Loop.new(3, start: nil, stop: nil),
   Loop.new(4, start: nil, stop: nil),
   Loop.new(5, start: nil, stop: nil),
 ],
 :christophe => [
   Loop.new(1, start: nil, stop: nil),
   Loop.new(2, start: nil, stop: nil),
   Loop.new(3, start: nil, stop: nil),
   Loop.new(4, start: nil, stop: nil),
   Loop.new(5, start: nil, stop: nil),
  ],
 :claire => [
   Loop.new(1, start: nil, stop: nil),
   Loop.new(2, start: nil, stop: nil),
   Loop.new(3, start: nil, stop: nil),
   Loop.new(4, start: nil, stop: nil),
   Loop.new(5, start: nil, stop: nil),
 ],
 :craig => [
   Loop.new(1, start: nil, stop: nil),
   Loop.new(2, start: nil, stop: nil),
   Loop.new(3, start: nil, stop: nil),
   Loop.new(4, start: nil, stop: nil),
   Loop.new(5, start: nil, stop: nil),
 ],
 :damian => [
   Loop.new(1, start: nil, stop: nil),
   Loop.new(2, start: nil, stop: nil),
   Loop.new(3, start: nil, stop: nil),
   Loop.new(4, start: nil, stop: nil),
   Loop.new(5, start: nil, stop: nil),
 ],
 :harvey => [
   Loop.new(1, start: nil, stop: nil),
   Loop.new(2, start: nil, stop: nil),
   Loop.new(3, start: nil, stop: nil),
   Loop.new(4, start: nil, stop: nil),
   Loop.new(5, start: nil, stop: nil),
 ],
 :jasmin => [
   Loop.new(1, start: nil, stop: nil),
   Loop.new(2, start: nil, stop: nil),
   Loop.new(3, start: nil, stop: nil),
   Loop.new(4, start: nil, stop: nil),
   Loop.new(5, start: nil, stop: nil),
 ],
 :john => [
   Loop.new(1, start: nil, stop: nil),
   Loop.new(2, start: nil, stop: nil),
   Loop.new(3, start: nil, stop: nil),
   Loop.new(4, start: nil, stop: nil),
   Loop.new(5, start: nil, stop: nil),
 ],
 :christiana => [
   Loop.new(1, start: nil, stop: nil),
   Loop.new(2, start: nil, stop: nil),
   Loop.new(3, start: nil, stop: nil),
   Loop.new(4, start: nil, stop: nil),
   Loop.new(5, start: nil, stop: nil),
 ],
 :matej => [
   Loop.new(1, start: nil, stop: nil),
   Loop.new(2, start: nil, stop: nil),
   Loop.new(3, start: nil, stop: nil),
   Loop.new(4, start: nil, stop: nil),
   Loop.new(5, start: nil, stop: nil),
 ],
 :maxime => [
   Loop.new(1, start: nil, stop: nil),
   Loop.new(2, start: nil, stop: nil),
   Loop.new(3, start: nil, stop: nil),
   Loop.new(4, start: nil, stop: nil),
   Loop.new(5, start: nil, stop: nil),
 ],
 :sebastien => [
   Loop.new(1, start: nil, stop: nil),
   Loop.new(2, start: nil, stop: nil),
   Loop.new(3, start: nil, stop: nil),
   Loop.new(4, start: nil, stop: nil),
   Loop.new(5, start: nil, stop: nil),
 ],
 :thomas => [
   Loop.new(1, start: nil, stop: nil),
   Loop.new(2, start: nil, stop: nil),
   Loop.new(3, start: nil, stop: nil),
   Loop.new(4, start: nil, stop: nil),
   Loop.new(5, start: nil, stop: nil),
 ],
 :tomokazu => [
   Loop.new(1, start: nil, stop: nil),
   Loop.new(2, start: nil, stop: nil),
   Loop.new(3, start: nil, stop: nil),
   Loop.new(4, start: nil, stop: nil),
   Loop.new(5, start: nil, stop: nil),
 ]
}

Barkley.runners.each do |runner|
  runner.loops = data.fetch(runner.slugs.first)
end
