# frozen_string_literal: true
# The amazing awesomeness that is https://statistik.d-u-v.org
# Country codes used: https://en.wikipedia.org/wiki/ISO_3166-1

require_relative "config"
require "yaml"
require "forwardable"
require_relative "lib/barkley"

Profile = Data.define(:first_name, :last_name, :year, :nationality) do
  def name
    [first_name, last_name].compact.join(" ")
  end

  def age
    Time.now.year - year
  end
end
Status = Data.define(:state, :reason)
TheInterwebs = Data.define(:strava, :instagram, :twitter, :duv, :web, :wiki)

class Runner
  attr_accessor :slugs, :profile, :state, :the_inter_webs, :loops, :attempts, :notes, :finishes, :nick_name

  def initialize(slugs:, profile:, state:, the_inter_webs:, loops: [], notes: nil, attempts: 0, finishes: 0)
    @slugs = slugs
    @profile = profile
    @state = state
    @the_inter_webs = the_inter_webs
    @loops = loops
    @attempts = attempts
    @finishes = finishes
    @notes = notes
  end

  def key
    slugs.first
  end
end

web = ->(data) {
  TheInterwebs.new(**{strava: nil, instagram: nil, twitter: nil, duv: nil, web: nil, wiki: nil}.merge(data))
}

all = Dir.glob("#{Config.root}/data/2024/runners/*.yml").map do |yml|
  slug = File.basename(yml, ".yml")
  runner_data = YAML.load_file(yml).transform_keys(&:to_sym)
  notes = runner_data.delete(:notes) || ""
  profile = Profile.new(**runner_data.delete(:profile).transform_keys(&:to_sym))
  status = Status.new(**runner_data.delete(:state).transform_keys(&:to_sym))
  interwebs = web.(**runner_data.delete(:the_inter_webs).transform_keys(&:to_sym))
  runner = Runner.new(**runner_data.merge(profile: profile, state: status, the_inter_webs: interwebs, slugs: [slug]))
  runner.notes = notes
  runner
end

turns_out_not_running = [
  Runner.new(
    attempts: 1,
    slugs: [:claire],
    profile: Profile.new(
      first_name: "Claire", last_name: "Bannwarth",
      year: 1989,
      nationality: :fr,
    ),
    state: Status.new(state: :confirmed, reason: "On the list"),
    the_inter_webs: web.(
      duv: "https://statistik.d-u-v.org/getresultperson.php?runner=885641",
      web: "https://www.trailrunnermag.com/people/news/claire-bannwarth-fkt-colorado-trail/",
      instagram: "https://www.instagram.com/clairebannwarth/"
    )
  ),
]

class Runners
  include Enumerable
  extend Forwardable
  def_delegators :@data, :size, :length, :[], :empty?, :last, :index

  def initialize(data)
    @data = data
  end

  [
    :confirmed,
    :maybe,
    :likely
  ].each do |state|
    define_method state do
      @data.select{|r| r.state.state == state }
    end
  end

  def find!(key) = @data.detect{|r| r.key == key } || raise("No one named #{key}")
  def by_slug(string) = @data.detect{|r| r.slugs.include?(string)}
  def each(&block) = @data.each(&block)
end

Barkley.runners = Runners.new(all)
require_relative "models/loops"

Barkley.loops ||= {}
Dir.glob("#{Config.root}/data/2024/loops/*.yml").map do |yml|
  nickname = File.basename(yml, ".yml")
  loops_data = YAML.load_file(yml).transform_keys(&:to_sym)
  loops = loops_data.delete(:loops).map do |h|
    start = h[:start]
    if start[:time]
      start_update = Update.new(
        start[:time],
        start[:source],
        start[:text])
    end
    stop = h[:stop]
    if stop[:time]
      stop_update = Update.new(
        stop[:time],
        stop[:source],
        stop[:text])
    end
    Loop.new(h[:index], start: start_update, stop: stop_update, direction: h[:direction])
  end

  if runner_key = loops_data[:runner]
    runner = Barkley.runners.find!(runner_key.to_s)
    runner.nick_name = nickname
    runner.loops = loops
  end

  Barkley.loops[nickname] = [runner, loops]
end
