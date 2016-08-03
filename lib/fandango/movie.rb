module Fandango
  class Movie

    class << self

      def parse(description_node)
        description_node.css('li').map do |li|
          movie = new
          movie.title = parse_title(li)
          movie.id    = parse_id(li)
          movie
        end
      end

    private

      def parse_title(li)
        li.at_css('a').content
      end

      # E.g. '141081' in fandango.com/the+adventures+of+tintin+3d_141081/movietimes
      def parse_id(li)
        li.at_css('a')['href'].match(%r{fandango\.com/.*_(?<id>\d+)/movietimes})[:id]
      end

    end

    attr_accessor :title
    attr_accessor :id

  end
end
