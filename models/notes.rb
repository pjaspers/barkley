data = {
  :albert => <<~NOTES,
  A <a href="https://en.wikipedia.org/wiki/World_Rogaining_Championships">World Rogaining Champion</a> in 2022 (Also see <a href="/r/greig">Greig</a>)

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
 A <a href="https://en.wikipedia.org/wiki/World_Rogaining_Championships">World Rogaining Champion</a> in 2016 and 2017 (Also see <a href="/r/albert">Albert</a>) so you know he can navigate.

 In 2019 he finished Loop 3 and started Loop 4 (him and Karel Sabbe were the only to do so, but only had 12 hours to complete it), but came back some time later.

  In 2022 he made it to Loop 4, before timing out in that loop.
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
 Finished the Tor des Geants last year (614th), was the assist with 207km in 32 hours, can't find much else.
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
 :clarke => <<~NOTES,
From his Strava bio:

<blockquote>Ultra runner with two primary aspirational goals in the sport: 1) win more ultramarathons outright against all competition (won my 1st at The Last Annual Heart of the South, aka HOTS, in June 2022), and 2) complete at least a Fun Run (3 loops) within 40 hours at the Barkley Marathons.</blockquote>

Has ran the Barkley Fall Classic a couple of times and has finished MOAB multiple times.
  NOTES
  :iso => <<~NOTES,
  Has run a 6 days event 2023-12-28: <a href="https://www.strava.com/activities/10521175373">strava-link</a>
  NOTES
}

Barkley.runners.each do |runner|
  runner.notes = data.fetch(runner.slugs.first)
end
