class Loops
  def self.loops_from_yml(yml_path)
    nickname = File.basename(yml_path, ".yml")
    loops_data = YAML.load_file(yml_path).transform_keys(&:to_sym)
    loops = loops_data.delete(:loops).map do |h|
      from_data(h)
    end
    if runner_key = loops_data[:runner]
      runner = Barkley.runners.find!(runner_key.to_s)
      runner.nick_name = nickname
      runner.loops = loops
    end
    Barkley.loops[nickname] = [runner, loops]
  end

end
