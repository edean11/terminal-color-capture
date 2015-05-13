#!/usr/bin/env ruby
# -*- ruby -*-

require 'rake/clean'
require 'rake/testtask'

task :default => :test

Rake::TestTask.new() do |config|
    config.pattern = "test/**/test_*.rb"
end

desc 'bootstrap database structure'
task :bootstrap_database do
  require_relative 'lib/database'
  Database.load_structure
end