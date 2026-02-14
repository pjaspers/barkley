# frozen_string_literal: true
# The amazing awesomeness that is https://statistik.d-u-v.org
# Country codes used: https://en.wikipedia.org/wiki/ISO_3166-1

require_relative "config"
require "yaml"
require "forwardable"
require "tzinfo"
require_relative "lib/barkley"

require_relative "models/runner"
require_relative "models/runners"
require_relative "models/nickname"
