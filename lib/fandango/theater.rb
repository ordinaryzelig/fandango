module Fandango
  module Theater

    class << self

      def initialize(entry)
        @entry = entry
      end

      def parse(item_node, description_node = nil)
        description_node ||= Fandango::Parser.parse_description(item_node)
        name        = parse_name(item_node)
        id          = parse_id(item_node)
        address     = parse_address(description_node)
        postal_code = parse_postal_code(address)

        {
          name:        name,
          id:          id,
          address:     address,
          postal_code: postal_code,
        }
      end

      private

      def parse_name(item_node)
        item_node.at_css('title').content
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

  end
end
