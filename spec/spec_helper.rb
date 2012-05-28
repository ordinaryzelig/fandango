require 'bundler/setup'
Bundler.require :default, :development

require 'minitest/autorun'
require 'vcr'

# require support files.
Dir['./spec/support/**/*.rb'].each { |f| require f }

# VCR.
VCR.configure do |c|
  c.cassette_library_dir = 'spec/support/vcr_cassettes'
  c.hook_into :fakeweb
end
