require_relative "config"
require_relative "models"

require "roda"
require "tilt"
require "tilt/erubi"

class App < Roda
  plugin :public
  plugin :partials
  logger = if Config.test?
             Class.new{def write(_) end}.new
           else
             # :nocov:
             $stderr
             # :nocov:
           end
  plugin :common_logger, logger
  plugin :render, escape: false, layout: './layout', :template_opts=>{chain_appends: !defined?(SimpleCov), freeze: true, skip_compiled_encoding_detection: true}

  opts[:default_title] = "Barkley 2024"

  # :nocov:
  if Config.development?
    plugin :exception_page
  end
  # :nocov:

  route do |r|
    r.public

    r.on "r" do
      r.get String do |s|
        @runner = Barkley.runners.by_slug(s)

        view "runner"
      end
    end


    r.root do
      @runners = Barkley.runners

      view "index"
    end
  end
end
