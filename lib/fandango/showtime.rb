require 'fandango/movie'

module Fandango
  class Showtime

    class << self

      def parse(node)
        showtime = new
        datetime_str = node.at_css('time').attr('datetime')
        showtime.datetime = DateTime.parse(datetime_str)
        showtime
      end

    end

    attr_accessor :datetime

  end
end
