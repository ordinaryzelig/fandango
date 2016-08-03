module Fandango
  class Movie

    class << self

      def parse(description_li)
        Parser.(description_li)
      end

    end

    attr_accessor :title
    attr_accessor :id

    module Parser

      module_function

      def call(description_li)
        movie = Movie.new
        movie.title = parse_title(description_li)
        movie.id    = parse_id(description_li)
        movie
      end

      def parse_title(li)
        li.at_css('a').content
      end

      # E.g. '141081' in fandango.com/the+adventures+of+tintin+3d_141081/movietimes
      def parse_id(li)
        li.at_css('a')['href'].match(%r{fandango\.com/.*_(?<id>\d+)/movietimes})[:id]
      end

    end

  end
end
