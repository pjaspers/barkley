require_relative 'test_helper'

class BarkleyTest < Test
  it "cutoffs" do
    refute_nil Barkley.fun_run_cut_off
    refute_nil Barkley.full_run_cut_off
    refute_nil Barkley.final_cut_off
    refute_nil Barkley.elapsed
    refute_nil Barkley.start
  end
end
