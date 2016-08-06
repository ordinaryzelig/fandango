module Fandango
  class Showtime

    PREVIEW_MINUTES = 20

    include Comparable

    class << self

      def parse(node)
        Parser.(node)
      end

    end

    attr_accessor :movie
    attr_accessor :datetime

    def feature_start_time
      @datetime + PREVIEW_MINUTES.to_f / 24 / 60
    end

    def feature_end_time
      feature_start_time + movie.runtime.to_f / 24 / 60
    end

  protected

    def <=>(showtime)
      datetime <=> showtime.datetime
    end

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
