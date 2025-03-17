require_relative "./loop"

class Nickname

  def self.from_yml(yml_path, edition:)
    nickname = File.basename(yml_path, ".yml")
    loops_data = YAML.load_file(yml_path).transform_keys(&:to_sym)
    loops = loops_data.delete(:loops).map do |h|
      Loop.from_data(h, barkley_start: edition.start)
    end
    new(name: nickname, runner: loops_data[:runner], loops: loops, edition: edition)
  end

  attr_accessor :loops
  def initialize(name:, runner:, edition:, loops:)
    @name = name
    @loops = loops
    @runner = runner
    @edition = edition
  end

  def name
    @name.to_s.split("_").map(&:capitalize).join(" ")
  end

  def runner
    return unless @runner

    runner = @edition.runners.find!(@runner.to_s)
    runner.nick_name = @name
    runner.loops = @loops
    runner
  end
end
