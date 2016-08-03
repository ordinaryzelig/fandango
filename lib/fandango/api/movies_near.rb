require 'fandango/theater'

module Fandango
  module MoviesNear

    module_function

    def call(postal_code)
      response = request(postal_code)
      raise BadResponse.new(response) unless response.status.first == '200'

      source = response.read
      Parser.(source)
    end

    def request(postal_code)
      cleaned_postal_code = postal_code.to_s.gsub(' ', '')
      url_for_postal_code = "http://www.fandango.com/rss/moviesnearme_#{cleaned_postal_code}.rss"
      open(url_for_postal_code)
    end

    module Parser

      module_function

      def call(source)
        doc = Nokogiri.XML(source)
        doc.css('item').map do |item_node|
          Theater.parse(item_node)
        end
      end

    end

    class BadResponse < API::BadResponse; end

  end
end
