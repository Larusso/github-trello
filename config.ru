$:.unshift(File.expand_path('../lib', __FILE__))
require 'rubygems'
require 'bundler'

Bundler.require

require 'listen'

stdout.sync = true
config.logger = Logger.new(STDOUT)

run GithubTrello

