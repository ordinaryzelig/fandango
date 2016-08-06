require "bundler/gem_tasks"
require 'rake/testtask'

task :default => :test

Rake::TestTask.new(:test) do |t|
  t.pattern = 'spec/**/*.spec.rb'
  t.warning = false
end

task :cli do
  require 'bundler/setup'
  Bundler.require

  require 'fandango'
  require 'fandango/cli'

  ARGV.clear
  Fandango::CLI.new.run
end
