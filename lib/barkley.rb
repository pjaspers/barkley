module Barkley
  class << self
    attr_accessor :runners, :loops

    def conch_blown = Time.new(2024, 03, 20, 4, 17, 0, "-04:00")
    def start = conch_blown + 1*60*60
    def elapsed = Time.now - start
    def end_time = start + duration_to_sec("60:00:00")
    def full_run_cut_off = start + duration_to_sec("36:00:00")
    # Fun run is three loops, once you start for a 4th it's no longer a fun run
    # Need to finish before 40h
    def fun_run_cut_off = start + duration_to_sec("40:00:00")

    # Sort the loops in a way that the person who's in the furthest
    # loop is on top, and the rest is behind that
    def sorted_loops
      Barkley.loops.sort_by do |_nickname, (runner,loops)|
        loops.map(&:score).inject(:+)
      end.reverse
    end

    private def duration_to_sec(duration)
      seconds, minutes, hours = duration.split(":").reverse

      (hours.to_i * 60 * 60) + (minutes.to_i * 60) + seconds.to_i
    end
  end
end
