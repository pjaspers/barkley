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
