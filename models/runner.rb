require_relative "./profile"
require_relative "./status"
require_relative "./the_interwebs"
require "yaml"

class Runner
  attr_accessor :slugs, :profile, :the_inter_webs, :loops, :notes, :nick_name

  def self.from_yml(yml_path)
    slug = File.basename(yml_path, ".yml")
    data = YAML.load_file(yml_path)

    profile = Profile.new(**data["profile"].transform_keys(&:to_sym))
    interwebs = TheInterwebs.from_data(**data["the_inter_webs"].transform_keys(&:to_sym))

    runner = Runner.new(
      slugs: [slug],
      profile: profile,
      the_inter_webs: interwebs,
      notes: data["notes"] || "",
      years: data["years"] || {}
    )
    runner
  end

  def initialize(slugs:, profile:, the_inter_webs:, years: {}, notes: nil)
    @slugs = slugs
    @profile = profile
    @the_inter_webs = the_inter_webs
    @years = years
    @notes = notes
  end

  def attempts(year: nil)
    if year
      @years.keys.select{|y| y <= year}.count
    else
      @years.keys.count
    end
  end

  def state(year:)
    return {} unless running?(year)

    year_data = @years[year]
    Status.new(state: year_data["state"], reason: year_data["reason"])
  end

  def finishes
    @years.count { |_, data| data.is_a?(Hash) && data["finished"] }
  end

  def running?(year)
    @years.key?(year)
  end

  def key
    slugs.first
  end
end
