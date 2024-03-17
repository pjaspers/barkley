# frozen_string_literal: true
# The amazing awesomeness that is https://statistik.d-u-v.org
# Country codes used: https://en.wikipedia.org/wiki/ISO_3166-1

require "forwardable"

Profile = Data.define(:first_name, :last_name, :year, :nationality) do
  def name
    [first_name, last_name].compact.join(" ")
  end
end
Status = Data.define(:state, :reason)
TheInterwebs = Data.define(:strava, :instagram, :twitter, :duv)
Runner = Data.define(:slugs, :profile, :state, :the_inter_webs)

web = ->(data) {
  TheInterwebs.new(**{strava: nil, instagram: nil, twitter: nil, duv: nil}.merge(data))
}

all = [
  Runner.new(
    slugs: [:albert],
    profile: Profile.new(
      first_name: "Albert", last_name: "Herrero",
      year: 1982,
      nationality: :es
    ),
    state: Status.new(state: :confirmed, reason: ""),
    the_inter_webs: web.(
      duv: "https://statistik.d-u-v.org/getresultperson.php?runner=641169"
    )
  ),
  Runner.new(
    slugs: [:christophe],
    profile: Profile.new(
      first_name: "Christophe", last_name: "Nonorgue",
      year: 1980,
      nationality: :ch
    ),
    state: Status.new(state: :maybe, reason: "Ran last year + strava"),
    the_inter_webs: web.(
      strava: "https://www.strava.com/pros/7068194",
      duv: "https://statistik.d-u-v.org/getresultperson.php?runner=202867"
    )
  ),
  Runner.new(
    slugs: [:damian],
    profile: Profile.new(
      first_name: "Damian", last_name: "Hall",
      year: 1975,
      nationality: :gb
    ),
    state: Status.new(state: :likely, reason: "Ran last year + strava"),
    the_inter_webs: web.(
      strava: "https://www.strava.com/pros/7068194",
      duv: "https://statistik.d-u-v.org/getresultperson.php?runner=431093"
    ),
  ),
  Runner.new(
    slugs: [:filippo],
    profile: Profile.new(
      first_name: "Filippo", last_name: "Meloni",
      year: 1973,
      nationality: :ch
    ),
    state: Status.new(state: :likely, reason: "Hinted on instagram"),
    the_inter_webs: web.(
      strava: "https://www.strava.com/athletes/16900600",
      duv: "https://statistik.d-u-v.org/getresultperson.php?runner=1620249"
    ),
  ),
  Runner.new(
    slugs: [:harvey],
    profile: Profile.new(
      first_name: "Harvey", last_name: "Lewis",
      year: 1976,
      nationality: :us
    ),
    state: Status.new(state: :confirmed, reason: "Mentioned a lot on instagram"),
    # https://en.wikipedia.org/wiki/Harvey_Sweetland_Lewis
    the_inter_webs: web.(
      duv: "https://statistik.d-u-v.org/getresultperson.php?runner=19568"
    )
  ),
  Runner.new(
    slugs: [:jasmin],
    profile: Profile.new(
      first_name: "Jasmin", last_name: "Paris",
      year: 1983,
      nationality: :gb,
    ),
    state: Status.new(state: :maybe, reason: "Ran last year"),
    the_inter_webs:   web.(
      duv: "https://statistik.d-u-v.org/getresultperson.php?runner=279245"
    )
  ),
  Runner.new(
    slugs: [:john],
    profile: Profile.new(
      first_name: "John", last_name: "Kelly",
      year: 1984,
      nationality: :us,
    ),
    state: Status.new(state: :likely, reason: "Ran last year + strava"),
    the_inter_webs: web.(
      strava: "https://www.strava.com/athletes/16389235",
      duv: "https://statistik.d-u-v.org/getresultperson.php?runner=788718"
    ),
  ),
  Runner.new(
    slugs: [:christiana],
    profile: Profile.new(
      first_name: "Christiana", last_name: "Rugloski",
      year: 1996,
      nationality: :us,
    ),
    state: Status.new(state: :probably, reason: "Winner of Fall Barkley"),
    the_inter_webs: web.(
      strava: "https://www.strava.com/athletes/71706675",
      duv: "https://statistik.d-u-v.org/getresultperson.php?runner=1079915"
    ),
  ),
  Runner.new(
    slugs: [:maxime],
    profile: Profile.new(
      first_name: "Maxime", last_name: "Gauduin",
      year: 1987,
      nationality: :fr,
    ),
    state: Status.new(state: :confirmed, reason: "Mentioned it on strava"),
    the_inter_webs:   web.(
      strava: "https://www.strava.com/athletes/6388725",
      duv: "https://statistik.d-u-v.org/getresultperson.php?runner=700478"
    ),
  ),
  Runner.new(
    slugs: [:thomas],
    profile: Profile.new(
      first_name: "Thomas", last_name: "Dunkerbeck",
      year: 1976,
      nationality: :nl,
    ),
    state: Status.new(state: :likely, reason: "Hinted on instagram"),
    the_inter_webs: web.(
      strava: "https://www.strava.com/athletes/58683376",
      duv: "https://statistik.d-u-v.org/getresultperson.php?runner=89316"
    ),
  ),
  Runner.new(
    slugs: [:tomokazu],
    profile: Profile.new(
      first_name: "Tomokazu", last_name: "Ihara",
      year: 1977,
      nationality: :jp,
    ),
    state: Status.new(state: :likely, reason: "Ran last year + strava"),
    the_inter_webs: web.(
      strava: "https://www.strava.com/pros/4651420",
      duv: "https://statistik.d-u-v.org/getresultperson.php?runner=161561",
    ),
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

  def by_slug(string) = @data.detect{|r| r.slugs.include?(string.to_sym)}
  def each(&block) = @data.each(&block)
end

RUNNERS = Runners.new(all)
