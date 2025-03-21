require_relative "config"
require_relative "models"

require "roda"
require "tilt"
require "tilt/erubi"

class App < Roda
  plugin :public, headers: { 'Cache-Control' => 'max-age=31536000, immutable' }
  plugin :partials
  plugin :timestamp_public

  logger = if Config.test?
             Class.new{def write(_) end}.new
           else
             # :nocov:
             $stderr
             # :nocov:
           end
  plugin :common_logger, logger
  plugin :render, escape: false, layout: './layout', :template_opts=>{chain_appends: !defined?(SimpleCov), freeze: true, skip_compiled_encoding_detection: true}

  opts[:default_title] = "Barkley 2025"

  # :nocov:
  if Config.development?
    plugin :exception_page
  end
  # :nocov:

  route do |r|
    r.timestamp_public
    r.public

    r.on "2024" do
      @edition = Barkley::Edition.for_year(2024)

      r.on "r" do
        r.get String do |s|
          @runner = @edition.runners.by_slug(s)

          view "runner"
        end
      end

      r.get "loops" do
        view "loops"
      end

      r.get(true) do
        view "index"
      end
    end


    @edition = Barkley::Edition.for_year(2025)
    r.on "r" do
      r.get String do |s|
        @runner = @edition.runners.by_slug(s)

        view "runner"
      end
    end

    r.get "loops" do
      view "loops"
    end

    r.root do
      view "index"
    end
  end

  def local_time(time)
    <<~HTML
    <relative-time datetime="#{time.iso8601}" format="datetime" hour="numeric" minute="numeric" second="numeric">
      #{time.strftime("%d %M %Y %H:%M")}
    </relative-time>
    HTML
  end

  def elapsed(time, style: "short")
    <<~HTML
    <relative-time datetime="#{time.iso8601}" format="duration" hour="numeric" minute="numeric" second="numeric" format-style="#{style}">
      #{Time.now - time} seconds
    </relative-time>
    HTML
  end

  def runner_a(key)
    if @edition.year == 2025
      "/r/#{key}"
    else
      "/#{@edition.year}/r/#{key}"
    end
  end


  def hhmmss(seconds)
    "%02d:%02d:%02d" % hour_minute_seconds(seconds)
  end

  # Takes seconds and returns an array with [hour, minute, seconds]
  #
  #       hour_minute_seconds(710) => [0,11,50]
  def hour_minute_seconds(seconds)
    [60, 60, 100].collect do |count|
      next 0 unless seconds > 0

      seconds, n = seconds.divmod(count)
      n
    end.reverse
  end

  # Takes seconds and returns a human string
  #
  #       humanize(710) => "11 minutes and 50 seconds"
  def humanize(secs)
    hour, minute, seconds = hour_minute_seconds(secs)
    parts = []
    [[hour, ["hour", "hours"]],
     [minute, ["minute", "minutes"]],
     [seconds, ["second", "seconds"]]].each do |count, (singular, plural)|
      count = count.round
      parts << (count > 1 ? "#{count} #{plural}" : "#{count} #{singular}") if count > 0
    end
    parts.compact
    last = parts.pop
    if parts.count > 0
      "#{parts.join(", ")} and #{last}"
    else
      last
    end
  end
end
