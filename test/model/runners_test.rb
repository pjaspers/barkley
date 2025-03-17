require_relative 'test_helper'

class RunnersTest < Test
  edition = Barkley::Edition.for_year(2024)

  it "scope" do
    refute_nil edition.runners.confirmed
    refute_nil edition.runners.maybe
    refute_nil edition.runners.likely
  end
end
