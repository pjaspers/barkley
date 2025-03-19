module Barkley
  YEARS = {
    2024 => {
      conch_blown: Time.new(2024, 03, 20, 4, 17, 0, "-04:00"),
    },
    2025 => {
      # https://social.running.cafe/@KeithDunn/114183951364240283
      conch_blown: Time.new(2025, 03, 18, 10, 37, 0, "-04:00")
    }
  }

  class Edition
    attr_accessor :conch_blown, :year

    def self.for_year(year)
      new(conch_blown: Barkley::YEARS.dig(year, :conch_blown))
    end

    def initialize(conch_blown:)
      @conch_blown = conch_blown
      @year = conch_blown&.year || Time.now.year
    end

    def conch_blown?
      !!@conch_blown
    end

    def start = conch_blown + 1*60*60
    def elapsed = Time.now - start
    def end_time = start + duration_to_sec("60:00:00")

    def ongoing?
      return false if finished?
      return false unless conch_blown?

      true
    end

    def started?
      return false unless conch_blown?

      Time.now > start
    end

    def finished?
      return false unless conch_blown?

      Time.now > end_time
    end

    def runners
      all = Dir.glob("#{Config.root}/data/#{@year}/runners/*.yml").map do |yml_path|
        Runner.from_yml(yml_path)
      end
      Runners.new(all)
    end

    def nicknames
      Dir.glob("#{Config.root}/data/#{@year}/loops/*.yml").map do |yml_path|
        Nickname.from_yml(yml_path, edition: self)
      end
    end

    def cut_off(loop_number:)
      if loop_number < 3
        start + loop_number * duration_to_sec("13:20:00")
      else
        start + loop_number * duration_to_sec("12:00:00")
      end
    end

    def cut_off_fun_loop(loop_number:)
      raise "only loop 3 has a cut off for the fun loop" unless loop_number == 3

      start + loop_number * duration_to_sec("13:20:00")
    end

    # Sort the loops in a way that the person who's in the furthest
    # loop is on top, and the rest is behind that
    def sorted_nicknames(year: 2025)
      nicknames.sort_by do |nickname|
        nickname.loops.map(&:score).inject(:+)
      end.reverse
    end

    private def duration_to_sec(duration)
      seconds, minutes, hours = duration.split(":").reverse

      (hours.to_i * 60 * 60) + (minutes.to_i * 60) + seconds.to_i
    end
  end
end
