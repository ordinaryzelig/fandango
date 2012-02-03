module Fandango
  class Parser::Movie

    def initialize(entry)
      @entry = entry
    end

    # Return array of movie attributes.
    def parse
      @entry.summary_doc.css('li').map do |li|
        {
          title: parse_title(li),
          id:    parse_id(li),
        }
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
end
