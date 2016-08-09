require 'minitest/autorun'
require 'minitest/spec'

require 'pp'
module Minitest::Assertions
  def mu_pp obj
    obj.pretty_inspect
  end
end
