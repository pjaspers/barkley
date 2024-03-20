# frozen_string_literal: true
# The amazing awesomeness that is https://statistik.d-u-v.org
# Country codes used: https://en.wikipedia.org/wiki/ISO_3166-1

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
  attr_accessor :slugs, :profile, :state, :the_inter_webs, :loops, :attempts, :notes, :finishes
  def initialize(slugs:, profile:, state:, the_inter_webs:, loops: nil, notes: nil, attempts: 0, finishes: 0)
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

all = [
  Runner.new(
    attempts: 3,
    slugs: [:albert],
    profile: Profile.new(
      first_name: "Albert", last_name: "Herrero Casas",
      year: 1982,
      nationality: :es
    ),
    state: Status.new(state: :confirmed, reason: "Announced on instagram"),
    the_inter_webs: web.(
      duv: "https://statistik.d-u-v.org/getresultperson.php?runner=641169",
      instagram: "https://www.instagram.com/albertherrerotrail/"
    )
  ),
  Runner.new(
    attempts: 2,
    finishes: 1,
    slugs: [:aurelien],
    profile: Profile.new(
      first_name: "Aurélien", last_name: "Sanchez",
      year: 1991,
      nationality: :fr
    ),
    state: Status.new(state: :confirmed, reason: "On the list"),
    the_inter_webs: web.(
      instagram: "https://www.instagram.com/aurelien_sanchez_/",
      web: "https://www.kisskissbankbank.com/fr/projects/laresolution",
      duv: "https://statistik.d-u-v.org/getresultperson.php?runner=1348506",
      strava: "https://www.strava.com/athletes/20076562",
      wiki: "https://fr.wikipedia.org/wiki/Aurélien_Sanchez"
    )
  ),
  Runner.new(
    attempts: 2,
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
    attempts: 2,
    slugs: [:damian],
    profile: Profile.new(
      first_name: "Damian", last_name: "Hall",
      year: 1975,
      nationality: :gb
    ),
    state: Status.new(state: :likely, reason: "Ran last year + strava"),
    the_inter_webs: web.(
      strava: "https://www.strava.com/pros/7068194",
      duv: "https://statistik.d-u-v.org/getresultperson.php?runner=431093",
      instagram: "https://www.instagram.com/ultra_damo/",
      web: "https://linktr.ee/ultra_damo"
    ),
  ),
  Runner.new(
    attempts: 3,
    slugs: [:greig],
    profile: Profile.new(
      first_name: "Greig", last_name: "Hamilton",
      year: 1980,
      nationality: :us
    ),
    state: Status.new(state: :confirmed, reason: "On the list"),
    # Was World champion rogaining
    the_inter_webs: web.(
      duv: "https://statistik.d-u-v.org/getresultperson.php?runner=508680",
      web: "https://www.nzherald.co.nz/sport/kiwi-greig-hamiltons-incredible-effort-at-barkley-marathons/LI35KFHOSE745KMY5BUI4JNZUA/"
    )
  ),
  Runner.new(
    attempts: 3,
    slugs: [:harvey],
    profile: Profile.new(
      first_name: "Harvey", last_name: "Lewis",
      year: 1976,
      nationality: :us
    ),
    state: Status.new(state: :confirmed, reason: "Mentioned a lot on instagram"),
    the_inter_webs: web.(
      duv: "https://statistik.d-u-v.org/getresultperson.php?runner=19568",
      instagram: "https://www.instagram.com/harveylewisultrarunner/",
      web: "https://en.wikipedia.org/wiki/Harvey_Sweetland_Lewis"
    )
  ),
  Runner.new(
    attempts: 1,
    slugs: [:hendrik],
    profile: Profile.new(
      first_name: "Hendrik", last_name: "Boury",
      year: 1990,
      nationality: :de,
    ),
    state: Status.new(state: :confirmed, reason: "on the List"),
    the_inter_webs:   web.(
      duv: "https://statistik.d-u-v.org/getresultperson.php?runner=2022317"
    )
  ),
  Runner.new(
    attempts: 1,
    slugs: [:ihor],
    profile: Profile.new(
      first_name: "Ihor", last_name: "Verys",
      year: 1994,
      nationality: :ca
    ),
    state: Status.new(state: :likely, reason: "<a href='https://twitter.com/jos71634/status/1770051052257366200'>This tweet</a>"),
    the_inter_webs: web.(
      strava: "https://www.strava.com/athletes/33679522",
      duv: "https://statistik.d-u-v.org/getresultperson.php?runner=1725210"
    )
  ),
  Runner.new(
    attempts: 7,
    slugs: [:iso],
    profile: Profile.new(
      first_name: "Iso", last_name: "Yucra",
      year: 1968,
      nationality: :es
    ),
    state: Status.new(state: :confirmed, reason: "<a href='https://twitter.com/recore_b/status/1770276100792254944'>This tweet</a>"),
    the_inter_webs: web.(
      strava: "https://www.strava.com/athletes/18047935",
      duv: "https://statistik.d-u-v.org/getresultperson.php?runner=47665"
    )
  ),
  Runner.new(
    attempts: 8,
    slugs: [:jared],
    profile: Profile.new(
      first_name: "Jared", last_name: "Campbell",
      year: 1979,
      nationality: :us,
    ),
    state: Status.new(state: :confirmed, reason: "on photo"),
    the_inter_webs:   web.(
      duv: "https://statistik.d-u-v.org/getresultperson.php?runner=46981"
    )
  ),
  Runner.new(
    attempts: 3,
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
    attempts: 2,
    slugs: [:joe],
    profile: Profile.new(
      first_name: "Joe", last_name: "McConaughy",
      year: 1991,
      nationality: :us,
    ),
    state: Status.new(state: :confirmed, reason: "on photo"),
    the_inter_webs:   web.(
      duv: "https://statistik.d-u-v.org/getresultperson.php?runner=784193"
    )
  ),
  Runner.new(
    attempts: 2,
    slugs: [:clarke],
    profile: Profile.new(
      first_name: "John", last_name: "Clarke",
      year: 1965,
      nationality: :us,
    ),
    state: Status.new(state: :confirmed, reason: "Bio on Strava"),
    the_inter_webs: web.(
      strava: "https://www.strava.com/athletes/28619337",
      duv: "https://statistik.d-u-v.org/getresultperson.php?runner=213437"
    ),
  ),
  Runner.new(
    attempts: 7,
    finishes: 2,
    slugs: [:john],
    profile: Profile.new(
      first_name: "John", last_name: "Kelly",
      year: 1984,
      nationality: :us,
    ),
    state: Status.new(state: :likely, reason: "Ran last year + strava"),
    the_inter_webs: web.(
      strava: "https://www.strava.com/athletes/16389235",
      duv: "https://statistik.d-u-v.org/getresultperson.php?runner=788718",
      instagram: "https://www.instagram.com/randomforestrunner/"
    ),
  ),
  Runner.new(
    attempts: 1,
    slugs: [:christiana],
    profile: Profile.new(
      first_name: "Christiana", last_name: "Rugloski",
      year: 1996,
      nationality: :us,
    ),
    state: Status.new(state: :likely, reason: "Winner of Fall Barkley"),
    the_inter_webs: web.(
      strava: "https://www.strava.com/athletes/71706675",
      duv: "https://statistik.d-u-v.org/getresultperson.php?runner=1079915",
      instagram: "https://www.instagram.com/krisrugloski/"
    ),
  ),
  Runner.new(
    attempts: 1,
    slugs: [:matej],
    profile: Profile.new(
      first_name: "Matej", last_name: "Arnus",
      year: 1978,
      nationality: :si,
    ),
    state: Status.new(state: :likely, reason: "On Taka's list"),
    the_inter_webs: web.(
      duv: "https://statistik.d-u-v.org/getresultperson.php?runner=404460"
    )
  ),
  Runner.new(
    attempts: 1,
    slugs: [:maxime],
    profile: Profile.new(
      first_name: "Maxime", last_name: "Gauduin",
      year: 1987,
      nationality: :fr,
    ),
    state: Status.new(state: :confirmed, reason: "Mentioned it on strava"),
    the_inter_webs:   web.(
      strava: "https://www.strava.com/athletes/6388725",
      duv: "https://statistik.d-u-v.org/getresultperson.php?runner=700478",
      twitter: "https://twitter.com/maxx5907/status/1765779026956759477",
      instagram: "https://www.instagram.com/maximegauduin/"
    ),
  ),
  Runner.new(
    attempts: 1,
    slugs: [:sebastien],
    profile: Profile.new(
      first_name: "Sébastien", last_name: "Raichon",
      year: 1972,
      nationality: :fr
    ),
    state: Status.new(state: :confirmed, reason: "Announced <a href='https://www.mynaturalorigins.com/en/blog/sebastien-raichon-our-extreme-super-sports-star-will-be-taking-part-in-the-barkley-the-world-s-toughest-trail'>here</a>"),
    the_inter_webs: web.(
      duv: "https://statistik.d-u-v.org/getresultperson.php?runner=255597",
      instagram: "https://www.instagram.com/sebastienraichon/",
      strava: "https://www.strava.com/athletes/12694886",
    )
  ),
  Runner.new(
    attempts: 2,
    slugs: [:tano],
    profile: Profile.new(
      first_name: "Lenoardo", last_name: "'Tano' Isola",
      year: 1975,
      nationality: :ar,
    ),
    state: Status.new(state: :likely, reason: "On the list"),
    the_inter_webs: web.(
      instagram: "https://www.instagram.com/tano_isola/",
      duv: "https://statistik.d-u-v.org/getresultperson.php?runner=685434"
    ),
  ),
  Runner.new(
    attempts: 2,
    slugs: [:thomas],
    profile: Profile.new(
      first_name: "Thomas", last_name: "Dunkerbeck",
      year: 1976,
      nationality: :nl,
    ),
    state: Status.new(state: :confirmed, reason: "Posted on instagram"),
    the_inter_webs: web.(
      strava: "https://www.strava.com/athletes/58683376",
      duv: "https://statistik.d-u-v.org/getresultperson.php?runner=89316",
      instagram: "https://www.instagram.com/thomas_dunkerbeck/"
    ),
  ),
  Runner.new(
    attempts: 5,
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
      instagram: "https://www.instagram.com/rd_tomo/",
      web: "https://tomospit.com"
    ),
  ),
]

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

  def by_slug(string) = @data.detect{|r| r.slugs.include?(string.to_sym)}
  def each(&block) = @data.each(&block)
end

Barkley.runners = Runners.new(all)
require_relative "models/loops"
require_relative "models/notes"
