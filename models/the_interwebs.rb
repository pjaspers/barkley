TheInterwebs = Data.define(:strava, :instagram, :twitter, :duv, :web, :wiki)

class TheInterwebs
  def self.from_data(data)
    TheInterwebs.new(**{strava: nil, instagram: nil, twitter: nil, duv: nil, web: nil, wiki: nil}.merge(data))
  end
end
