module Fandango
  class Movie

    class << self

      def parse(node)
        Parser.(node)
      end

    end

    attr_accessor :title
    attr_accessor :id
    attr_accessor :runtime
    attr_reader   :showtimes

    def showtimes=(_showtimes)
      @showtimes = _showtimes
      @showtimes.each do |showtime|
        showtime.movie = self
      end
      @showtimes
    end

    def next_showtime(datetime)
      showtimes.detect { |st| datetime < st.feature_start_time }
    end

    module Parser

      module_function

      def call(node)
        movie = Movie.new

        a_tag = node.at_css('a.showtimes-movie-title') || node.at_css('a')
        movie.title   = parse_title(a_tag)
        movie.id      = parse_id(a_tag)
        movie.runtime = parse_runtime(node)

        movie
      end

      def parse_title(a_tag)
        a_tag.content
      end

      # E.g. '141081' in fandango.com/the+adventures+of+tintin+3d_141081/movietimes
      def parse_id(a_tag)
        a_tag['href'].match(%r{fandango\.com/.*_(?<id>\d+)/})[:id]
      end

      # <div class="showtimes-movie-rating-runtime">
      # <!-- Display rating -->
      # R , 
      #   <!-- Display runtime -->
      # 1 hr 41 min
      # </div>
      def parse_runtime(node)
        if rating_runtime = node.at_css('.showtimes-movie-rating-runtime')
          %r{(?<hour>\d+)\s+hr\s+(?<min>\d+)} =~ rating_runtime.content
          begin
            Integer(hour) * 60 + Integer(min)
          rescue TypeError
            #puts rating_runtime
          end
        end
      end

    end

  end
end
