require_relative 'test_helper'

class RunnersTest < Test
  edition = Barkley::Edition.for_year(2024)

  it "scope" do
    refute_nil edition.runners.confirmed
    refute_nil edition.runners.maybe
    refute_nil edition.runners.likely
  end

  it "computes attempts from prior_attempts and year count" do
    john_2024 = Barkley::Edition.for_year(2024).runners.by_slug("john")
    john_2025 = Barkley::Edition.for_year(2025).runners.by_slug("john")
    john_2026 = Barkley::Edition.for_year(2026).runners.by_slug("john")

    assert_equal john_2024.attempts + 1, john_2025.attempts
    assert_equal john_2025.attempts + 1, john_2026.attempts
  end

  it "running? reflects which years a runner participates in" do
    harald = Runner.from_yml("#{Config.root}/data/runners/harald.yml")

    assert harald.running?(2024)
    refute harald.running?(2025)
  end

  it "filters runners not in a given year" do
    assert_nil Barkley::Edition.for_year(2025).runners.by_slug("harald")
  end
end
