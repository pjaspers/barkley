require_relative 'test_helper'

class BarkleyTest < Test
  [1,2,3,4,5].each do |i|
    it "loop #{i} fun run" do
      refute_nil Barkley::Edition.for_year(2024).cut_off(loop_number: i, fun_run: true)
    end

  it "loop #{i}" do
      refute_nil Barkley::Edition.for_year(2024).cut_off(loop_number: i, fun_run: false)
    end
  end
  it "cutoffs" do
    refute_nil Barkley::Edition.for_year(2024).elapsed
    refute_nil Barkley::Edition.for_year(2024).start
  end


  Barkley::Edition.for_year(2024).runners.each do |runner|
    # Can't find a pic for matej
    next if runner.key == "matej"

    it "#{runner.key} has a jpeg" do
      assert File.exist?(root.join("public/runners/#{runner.key}.jpg"))
    end
  end

  Barkley::Edition.for_year(2025).runners.each do |runner|
    # Can't find a pic for matej
    next if runner.key == "matej"

    it "#{runner.key} has a jpeg" do
      assert File.exist?(root.join("public/runners/#{runner.key}.jpg"))
    end
  end

  it "ongoing?" do
    assert Barkley::Edition.new(conch_blown: Time.now - 24*60*50).ongoing?
    refute Barkley::Edition.new(conch_blown: Time.now - 7*24*60*50).ongoing?
  end

  it "started?" do
    refute Barkley::Edition.new(conch_blown: Time.now).started?
    refute Barkley::Edition.new(conch_blown: nil).started?
    assert Barkley::Edition.new(conch_blown: Time.now - 1*60*60 - 1).started?
  end
end
