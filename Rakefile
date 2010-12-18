# -*- encoding: utf-8 -*-
$:.unshift File.expand_path("../lib", __FILE__)

require 'rubygems'
require 'rubygems/specification'
require 'gendarme'

begin
  require 'rspec/core/rake_task'

  desc "Run specs"
  RSpec::Core::RakeTask.new do |t|
    t.rspec_opts = %w(-fs --color)
    t.ruby_opts  = %w(-w)
  end

rescue LoadError
  task :spec do
    abort "Run `gem install rspec` to be able to run specs"
  end
end

task :default => :spec
