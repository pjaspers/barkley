require_relative 'test_helper'

class BarkleyTest < Test
  [1,2,3,4,5].each do |i|
    it "loop #{i} fun run" do
      refute_nil Barkley.cut_off(loop_number: i, fun_run: true)
    end

  it "loop #{i}" do
      refute_nil Barkley.cut_off(loop_number: i, fun_run: false)
    end
  end
  it "cutoffs" do
    refute_nil Barkley.elapsed
    refute_nil Barkley.start
  end

  Barkley.runners.each do |runner|
    # Can't find a pic for matej
    next if runner.key == "matej"

    it "#{runner.key} has a jpeg" do
      assert File.exist?(root.join("public/runners/#{runner.key}.jpg"))
    end
  end
end
