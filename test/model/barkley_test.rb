require_relative 'test_helper'

class BarkleyTest < Test
  it "cutoffs" do
    refute_nil Barkley.fun_run_cut_off
    refute_nil Barkley.full_run_cut_off
    refute_nil Barkley.final_cut_off
    refute_nil Barkley.elapsed
    refute_nil Barkley.start
  end

  Barkley.runners.each do |runner|
    # Can't find a pic for matej
    next if runner.key == :matej

    it "#{runner.key} has a jpeg" do
      assert File.exist?(root.join("public/runners/#{runner.key}.jpg"))
    end
  end
end
