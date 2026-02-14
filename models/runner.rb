require_relative "./profile"
require_relative "./status"
require_relative "./the_interwebs"
require "yaml"

class Runner
  attr_accessor :slugs, :profile, :state, :the_inter_webs, :loops, :attempts, :notes, :finishes, :nick_name

  def self.from_yml(yml_path)
    slug = File.basename(yml_path, ".yml")
    data = YAML.load_file(yml_path)

    profile = Profile.new(**data["profile"].transform_keys(&:to_sym))
    interwebs = TheInterwebs.from_data(**data["the_inter_webs"].transform_keys(&:to_sym))

    runner = Runner.new(
      slugs: [slug],
      profile: profile,
      the_inter_webs: interwebs,
      finishes: data["finishes"] || 0,
      notes: data["notes"] || "",
      years: data["years"] || {}
    )
    runner
  end

  def initialize(slugs:, profile:, the_inter_webs:, years: {}, loops: [], notes: nil, finishes: 0, state: nil, attempts: 0)
    @slugs = slugs
    @profile = profile
    @the_inter_webs = the_inter_webs
    @years = years
    @loops = loops
    @notes = notes
    @finishes = finishes
    @state = state
    @attempts = attempts
  end

  def running?(year)
    @years.key?(year)
  end

  def for_year(year)
    year_data = @years[year]
    @state = Status.new(state: year_data["state"], reason: year_data["reason"])
    @attempts = @years.keys.count { |y| y <= year }
    self
  end

  def key
    slugs.first
  end
end
