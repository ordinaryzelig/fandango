module Fandango
  module Movie

    class << self

      # Return array of movie attributes.
      def parse(description_node)
        description_node.css('li').map do |li|
          {
            title: parse_title(li),
            id:    parse_id(li),
            url:   parse_url(li),
          }
        end
      end

    private

      def parse_title(li)
        li.at_css('a').content
      end

      # E.g. '141081' in fandango.com/the+adventures+of+tintin+3d_141081/movietimes
      def parse_id(li)
        li.at_css('a')['href'].match(%r{fandango\.com(/|%2f).*_(?<id>\d+)(/|%2f)movietimes})[:id]
      end

      def parse_url(li)
        li.at_css('a')['href']
      end
    end

  end
end
