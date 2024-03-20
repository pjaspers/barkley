module Barkley
  class << self
    attr_accessor :runners

    def conch_blown = Time.new(2024, 03, 20, 4, 17, 0, "-04:00")
    def start = conch_blown + 1*60*60
    def elapsed = Time.now - start
    def final_cut_off = start + duration_to_sec("60:00:00")
    def full_run_cut_off = start + duration_to_sec("36:00:00")
    # Fun run is three loops, once you start for a 4th it's no longer a fun run
    # Need to finish before 40h
    def fun_run_cut_off = start + duration_to_sec("40:00:00")

    private def duration_to_sec(duration)
      seconds, minutes, hours = duration.split(":").reverse

      (hours.to_i * 60 * 60) + (minutes.to_i * 60) + seconds.to_i
    end
  end
end
