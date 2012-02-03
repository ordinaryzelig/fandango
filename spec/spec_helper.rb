require 'bundler/setup'
Bundler.require :default, :development

require 'minitest/autorun'
require 'mocha'

# require support files.
Dir['./spec/support/**/*.rb'].each { |f| require f }

class MiniTest::Spec
  include Macros
end
