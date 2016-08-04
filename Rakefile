require "bundler/gem_tasks"
require 'rake/testtask'

task :default => :test

Rake::TestTask.new(:test) do |t|
  t.pattern = 'spec/**/*.spec.rb'
  t.warning = false
end
