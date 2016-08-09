require 'bundler/setup'
Bundler.setup :default, :test

require 'fandango'

$LOAD_PATH.unshift __dir__

require 'support/minitest'
require 'awesome_print'
