require_relative 'test_helper'

class BarkleyTest < Test
  [1,2,3,4,5].each do |i|
    it "loop #{i}" do
      refute_nil Barkley::Edition.for_year(2024).cut_off(loop_number: i)
    end
  end
  it "cutoffs" do
    refute_nil Barkley::Edition.for_year(2024).elapsed
    refute_nil Barkley::Edition.for_year(2024).start
  end

  it "cut offs" do
    dts = ->(duration) {
      seconds, minutes, hours = duration.split(":").reverse

      (hours.to_i * 60 * 60) + (minutes.to_i * 60) + seconds.to_i
    }

    conch = Time.new(2024,03,01, 0, 0, 0, "-04:00")
    edition = Barkley::Edition.new(conch_blown: conch)
    assert_equal (edition.start + 1*dts["13:20:00"]), edition.cut_off(loop_number: 1)
    assert_equal (edition.start + 2*dts["13:20:00"]), edition.cut_off(loop_number: 2)
    assert_equal (edition.start + 3*dts["12:00:00"]), edition.cut_off(loop_number: 3)
    assert_equal (edition.start + 3*dts["13:20:00"]), edition.cut_off_fun_loop(loop_number: 3)
    assert_equal (edition.start + 4*dts["12:00:00"]), edition.cut_off(loop_number: 4)
    assert_equal (edition.start + 5*dts["12:00:00"]), edition.cut_off(loop_number: 5)
    assert_raises { edition.cut_off_fun_loop(loop_number: 1) }
  end

  Barkley::Edition.for_year(2024).runners.each do |runner|
    # Can't find a pic for matej or ian
    next if runner.key == "matej"

    it "#{runner.key} has a jpeg" do
      assert File.exist?(root.join("public/runners/#{runner.key}.jpg"))
    end
  end

  Barkley::Edition.for_year(2025).runners.each do |runner|
    # Can't find a pic for matej
    next if runner.key == "matej"
    next if runner.key == "julien"
    next if runner.key == "thomas_c"

    it "#{runner.key} has a jpeg" do
      assert File.exist?(root.join("public/runners/#{runner.key}.jpg"))
    end
  end

  it "ongoing?" do
    refute Barkley::Edition.new(conch_blown: nil).ongoing?
    assert Barkley::Edition.new(conch_blown: Time.now - 24*60*50).ongoing?
    refute Barkley::Edition.new(conch_blown: Time.now - 7*24*60*50).ongoing?
  end

  it "started?" do
    refute Barkley::Edition.new(conch_blown: Time.now).started?
    refute Barkley::Edition.new(conch_blown: nil).started?
    assert Barkley::Edition.new(conch_blown: Time.now - 1*60*60 - 1).started?
  end

  it "finished?" do
    refute Barkley::Edition.new(conch_blown: nil).finished?
    assert Barkley::Edition.new(conch_blown: Time.now - 5*24*60*60).finished?
  end
end
