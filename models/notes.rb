data = {
  :albert => <<~NOTES,
  A <a href="https://en.wikipedia.org/wiki/World_Rogaining_Championships">World Rogaining Champion</a> in 2022 (Also see <a href="/greig">Greig</a>)

  He did 3 loops in 2023 and 1 loop in 2022
  NOTES
  :aurelien => <<~NOTES,
  NOTES
 :christophe => <<~NOTES,
  NOTES
 :damian => <<~NOTES,
  NOTES
 :claire => <<~NOTES,
  NOTES
 :greig => <<~NOTES,
  NOTES
 :ihor => <<~NOTES,
 Ukranian-Canadian runner, was the assist to <a href="/harvey">'s win in the Big Dog Backyard (ran 717.5km in 108 hours)

 <a href="https://runningmagazine.ca/trail-running/meet-the-ukrainian-canadian-ultrarunner-who-is-winning-everything/">Runninmagazine.ca article</a>
 NOTES
 :harvey => <<~NOTES,
  NOTES
 :jasmin => <<~NOTES,
  NOTES
 :john => <<~NOTES,
  NOTES
 :christiana => <<~NOTES,
  NOTES
 :matej => <<~NOTES,
  NOTES
 :maxime => <<~NOTES,
  NOTES
 :sebastien => <<~NOTES,
  NOTES
 :tano => <<~NOTES,
 Don't know much about him, he participated in the 2021 Barkley.
  NOTES
 :thomas => <<~NOTES,
https://www.trailrunnermag.com/people/news/the-good-the-bad-and-the-barkley/
  NOTES
 :tomokazu => <<~NOTES,
https://www.rdrc.sg/blogs/news/rdrc-interview-with-tomokazu-ihara-the-barkley-marathons
  NOTES
}

Barkley.runners.each do |runner|
  runner.notes = data.fetch(runner.slugs.first)
end
