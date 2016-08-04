module Fandango
  class Theater

    class << self

      def parse(item_node)
        Parser.(item_node)
      end

    end

    attr_accessor :name
    attr_accessor :id
    attr_accessor :address
    attr_accessor :postal_code
    attr_accessor :showtimes_link
    attr_accessor :movies

    module Parser

      module_function

      def call(item_node)
        theater = Theater.new

        description_node = parse_description_node(item_node)

        theater.name           = parse_name(item_node)
        theater.id             = parse_id(item_node)
        theater.address        = parse_address(description_node)
        theater.postal_code    = parse_postal_code(theater.address)
        theater.showtimes_link = parse_showtimes_link(item_node)
        theater.movies         = parse_movies(description_node)
        theater
      end

      # Description content is in the form of HTML wrapped in CDATA.
      # Parse it and return a parsed Nokogiri node.
      def parse_description_node(item_node)
        cdata = item_node.at_css('description')
        Nokogiri::HTML(cdata.content)
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

      def parse_showtimes_link(item_node)
        item_node.at_css('link').content.strip
      end

      def parse_movies(description_node)
        description_node.css('li').map do |li|
          Movie.parse(li)
        end
      end

    end

  end
end
