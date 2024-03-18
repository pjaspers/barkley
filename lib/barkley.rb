module Barkley
  class << self
    attr_accessor :runners

    def start = Time.now
    def elapsed = Time.now - start
    def final_cut_off = start + duration_to_sec("60:00:00")
    def full_run_cut_off = start + duration_to_sec("36:00:00")
    def fun_run_cut_off = start + duration_to_sec("40:00:00")

    private def duration_to_sec(duration)
      seconds, minutes, hours = duration.split(":").reverse

      (hours.to_i * 60 * 60) + (minutes.to_i * 60) + seconds.to_i
    end
  end
end
