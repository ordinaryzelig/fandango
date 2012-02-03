module Fandango
  class Parser::Theater

    def initialize(entry)
      @entry = entry
    end

    # Compose hash with each attribute as key and result of #parse_<attribute> as value.
    def parse
      atts = [:name, :id, :address, :postal_code]
      atts.each_with_object({}) do |attr, hash|
        hash[attr] = send :"parse_#{attr}"
      end
    end

    private

    def parse_name
      @entry[:title]
    end

    # E.g. 'aaicu' in http://www.fandango.com/northpark7_aaicu/theaterpage
    def parse_id
      @entry[:url].match(%r{fandango\.com/.*_(?<id>.*)/theaterpage})[:id]
    end

    # Cache address in variable for postal_code.
    def parse_address
      @address = @entry.summary_doc.at_css('p').content
    end

    def parse_postal_code
      @address.match(/(?<postal_code>\d+)$/)[:postal_code]
    end

  end
end
