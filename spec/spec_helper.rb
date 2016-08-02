require 'bundler/setup'
Bundler.require :default, :development

require 'bundler'
Bundler.setup :default, :test

$LOAD_PATH.unshift __dir__

require 'minitest/autorun'
