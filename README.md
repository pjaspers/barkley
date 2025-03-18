
## Tracking the Barkley Marathons

There is no database, it's all just ruby and yaml, which makes it delightfully small and nimble. If you already have a ruby setup, you should be able to do a `git clone`, followed by a `bundle install` (assuming you have the right ruby, I've mostly landed on using https://mise.jdx.dev for that), and a `bundle exec puma` should have it running at http://localhost:9292

If you don't have a ruby setup, you can run the Dockerfile (that is used in production/fly.io as well):

- `scripts/build` (will build the docker image)
- `scripts/run` (will run it with the current dir mounted)

The data is stored in data/<year>, with a subdirectory for runners, which has all the data about the, you guessed it, runners. And a subdirectory `loops`, which has has all the data about the loops, but here I made the choice to name the files after the nickname that is used by Keith.

So that way we can add the loop data to the nickname and once we figure out which runner it is, we can add it, and it should just work.
