# Migrate
migrate = lambda do |env, version|
  ENV['RACK_ENV'] = env
  require_relative 'db'
  require 'logger'
  Sequel.extension :migration
  DB.loggers << Logger.new($stdout) if DB.loggers.empty?
  Sequel::Migrator.apply(DB, 'migrations', version)
end

desc "Migrate development database to latest version"
task :up do
  migrate.call('development', nil)
end

desc "Migrate development database to all the way down"
task :down do
  migrate.call('development', 0)
end

desc "Migrate development database all the way down and then back up"
task :bounce do
  migrate.call('development', 0)
  Sequel::Migrator.apply(DB, 'migrations')
end

desc "Migrate test database to latest version"
task :test_up do
  migrate.call('test', nil)
end

desc "Migrate test database all the way down"
task :test_down do
  migrate.call('test', 0)
end

desc "Migrate test database all the way down and then back up"
task :test_bounce do
  migrate.call('test', 0)
  Sequel::Migrator.apply(DB, 'migrate')
end

seed = lambda do |env|
  ENV['RACK_ENV'] = env
  return unless env == "development"

  require_relative 'models'
end

desc "Seed"
task :seed do
  seed.call("development")
end

task :test_seed do
  seed.call("test")
end

# Shell

irb = proc do |env|
  ENV['RACK_ENV'] = env
  trap('INT', "IGNORE")
  dir, base = File.split(FileUtils::RUBY)
  cmd = if base.sub!(/\Aruby/, 'irb')
    File.join(dir, base)
  else
    "#{FileUtils::RUBY} -S irb"
  end
  sh "#{cmd} -r ./models"
end

desc "Open irb shell in test mode"
task :test_irb do
  irb.call('test')
end

desc "Open irb shell in development mode"
task :dev_irb do
  irb.call('development')
end

desc "Open irb shell in production mode"
task :prod_irb do
  irb.call('production')
end

# Specs

test = proc do |type|
  desc "Run #{type} tests"
  task :"#{type}_test" do
    sh "#{FileUtils::RUBY} -w test/#{type}.rb"
  end

  desc "Run #{type} tests with coverage"
  task :"#{type}_test_cov" do
    ENV['COVERAGE'] = type
    sh "#{FileUtils::RUBY} test/#{type}.rb"
    ENV.delete('COVERAGE')
  end
end

test.call('web')
test.call('model')

desc "Run all tests"
task default: [:web_test, :model_test]

desc "Run all tests with coverage"
task :test_cov do
  ENV['RODA_RENDER_COMPILED_METHOD_SUPPORT'] = 'no'
  FileUtils.rm_r('coverage') if File.directory?('coverage')
  Dir.mkdir('coverage')
  Rake::Task['_test_cov'].invoke
end
task _test_cov: [:web_test_cov, :model_test_cov]

# Other

desc "Generate a new .env.rb"
task :overwrite_envrb do
  require "securerandom"

  File.write(".env.rb", <<ENVRB)
# frozen_string_literal: true

case ENV["RACK_ENV"] ||= "development"
when "test"
else
end
ENVRB
end

desc "Annotate Sequel models"
task "annotate" do
  ENV['RACK_ENV'] = 'development'
  require_relative 'models'
  DB.loggers.clear
  require 'sequel/annotate'
  Sequel::Annotate.annotate(Dir['models/**/*.rb'])
end

desc "Reset test"
task test_reset: [:test_clear, :test_up, :test_seed]

desc "Clear test database"
task "test_clear" do
  path = "data/leapy-ear_test.db"
  if File.exist?(path)
    File.unlink(path)
  else
    # Make sure there is a data dir
    require "fileutils"
    FileUtils.mkdir_p("data")
  end
end
