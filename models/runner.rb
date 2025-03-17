require_relative "./profile"
require_relative "./status"
require_relative "./the_interwebs"
require "yaml"

class Runner
  attr_accessor :slugs, :profile, :state, :the_inter_webs, :loops, :attempts, :notes, :finishes, :nick_name

  def self.from_yml(yml_path)
    slug = File.basename(yml_path, ".yml")
    runner_data = YAML.load_file(yml_path).transform_keys(&:to_sym)
    notes = runner_data.delete(:notes) || ""
    profile = Profile.new(**runner_data.delete(:profile).transform_keys(&:to_sym))
    status = Status.new(**runner_data.delete(:state).transform_keys(&:to_sym))
    interwebs = TheInterwebs.from_data(**runner_data.delete(:the_inter_webs).transform_keys(&:to_sym))
    runner = Runner.new(**runner_data.merge(profile: profile, state: status, the_inter_webs: interwebs, slugs: [slug]))
    runner.notes = notes
    runner

  end

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
