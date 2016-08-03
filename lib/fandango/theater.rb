module Fandango
  class Theater

    class << self

      def parse(item_node)
        theater = new

        description_node = parse_description_node(item_node)

        theater.name        = parse_name(item_node)
        theater.id          = parse_id(item_node)
        theater.address     = parse_address(description_node)
        theater.postal_code = parse_postal_code(theater.address)
        theater.movies      = Movie.parse(description_node)
        theater
      end

    private

      # Description content is in the form of HTML wrapped in CDATA.
      # Parse it and return a parsed Nokogiri node.
      def parse_description_node(item_node)
        @description_node =
          begin
            cdata = item_node.at_css('description')
            Nokogiri::HTML(cdata.content)
          end
      end

      def parse_name(item_node)
        item_node.at_css('title').content.strip
      end

      # E.g. 'aaicu' in http://www.fandango.com/northpark7_aaicu/theaterpage
      def parse_id(item_node)
        item_node.
          at_css('link').
          content.
          match(%r{fandango\.com/.*_(?<id>.*)/theaterpage})[:id]
      end

      def parse_address(description_node)
        description_node.at_css('p').content
      end

      def parse_postal_code(address)
        address.match(/(?<postal_code>\d+)$/)[:postal_code]
      end

    end

    attr_accessor :name
    attr_accessor :id
    attr_accessor :address
    attr_accessor :postal_code
    attr_accessor :movies

  end
end
