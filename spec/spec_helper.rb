require 'bundler/setup'
Bundler.setup :default, :test

require 'fandango'

$LOAD_PATH.unshift __dir__

require 'minitest/autorun'
require 'minitest/spec'
