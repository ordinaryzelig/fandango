module Fandango
  module MoviesNear

    module_function

    def call(postal_code)
      response = request(postal_code)
      raise BadResponse.new(response) unless response.status.first == '200'

      xml = response.read
      Parser.(xml)
    end

    def request(postal_code)
      cleaned_postal_code = postal_code.to_s.gsub(' ', '')
      url_for_postal_code = "http://www.fandango.com/rss/moviesnearme_#{cleaned_postal_code}.rss"
      open(url_for_postal_code)
    end

    module Parser

      module_function

      def call(xml)
        doc = Nokogiri.XML(xml)
        doc.css('item').map do |item_node|
          Theater.parse(item_node)
        end
      end

    end

    class BadResponse < API::BadResponse; end

  end
end
