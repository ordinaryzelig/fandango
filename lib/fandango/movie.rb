module Fandango
  class Movie

    class << self

      def parse(a_tag)
        Parser.(a_tag)
      end

    end

    attr_accessor :title
    attr_accessor :id
    attr_accessor :showtimes

    module Parser

      module_function

      def call(a_tag)
        movie = Movie.new
        movie.title = parse_title(a_tag)
        movie.id    = parse_id(a_tag)
        movie
      end

      def parse_title(a_tag)
        a_tag.content
      end

      # E.g. '141081' in fandango.com/the+adventures+of+tintin+3d_141081/movietimes
      def parse_id(a_tag)
        a_tag['href'].match(%r{fandango\.com/.*_(?<id>\d+)/})[:id]
      end

    end

  end
end
