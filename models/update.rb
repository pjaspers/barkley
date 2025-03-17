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
