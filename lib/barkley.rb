module Barkley
  class << self
    attr_accessor :runners, :loops

    def conch_blown? = false
    def conch_blown = Time.new(2024, 03, 20, 4, 17, 0, "-04:00")
    def start = conch_blown + 1*60*60
    def elapsed = Time.now - start
    def end_time = start + duration_to_sec("60:00:00")

    def cut_off(loop_number:, fun_run:)
      if fun_run
        start + loop_number * duration_to_sec("13:20:00")
      else
        start + loop_number * duration_to_sec("12:00:00")
      end
    end

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
