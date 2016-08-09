module Fandango
  module Theater

    module_function

    def parse(item_node)
      hash = {}

      description_node = parse_description_node(item_node)

      hash[:name]           = parse_name(item_node)
      hash[:id]             = parse_id(item_node)
      hash[:address]        = parse_address(description_node)
      hash[:postal_code]    = parse_postal_code(hash[:address])
      hash[:showtimes_link] = parse_showtimes_link(item_node)
      hash[:movies]         = parse_movies(description_node)

      hash
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
