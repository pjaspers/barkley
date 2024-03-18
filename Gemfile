source "https://rubygems.org"

ruby "3.3.0"

gem "rake"
gem "roda"
gem "tilt"
gem "erubi"
gem 'puma'
gem "base64"

# https://github.com/sparklemotion/sqlite3-ruby/issues/372
platforms :ruby do
  gem "sqlite3", force_ruby_platform: true
end

group :development do
  gem "rackup"
  gem "webrick", "~> 1.8.1"
  gem 'simplecov'
end

group :test do
  gem "capybara"
  gem "minitest"
  gem "minitest-hooks"
end
