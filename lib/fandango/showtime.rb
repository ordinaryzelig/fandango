require 'fandango/movie'

module Fandango
  class Showtime

    class << self

      def parse(node)
        Parser.(node)
      end

    end

    attr_accessor :datetime

    module Parser

      module_function

      def call(node)
        showtime = Showtime.new
        showtime.datetime = parse_datetime(node)
        showtime
      end

      def parse_datetime(node)
        datetime_str = node.at_css('time').attr('datetime')
        DateTime.parse(datetime_str)
      end

    end

  end
end
