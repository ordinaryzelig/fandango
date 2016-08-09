module Fandango
  module Movie

    module_function

    def parse(node)
      a_tag = node.at_css('a.showtimes-movie-title') || node.at_css('a')
      {
        title:   parse_title(a_tag),
        id:      parse_id(a_tag),
        #runtime: parse_runtime(node),
      }
    end

    def parse_title(a_tag)
      a_tag.content
    end

    # E.g. '141081' in fandango.com/the+adventures+of+tintin+3d_141081/movietimes
    def parse_id(a_tag)
      a_tag['href'].match(%r{fandango\.com/.*_(?<id>\d+)/})[:id]
    end

    # <div class="showtimes-movie-rating-runtime">
    # <!-- Display rating -->
    # R , 
    #   <!-- Display runtime -->
    # 1 hr 41 min
    # </div>
    def parse_runtime(node)
      if rating_runtime = node.at_css('.showtimes-movie-rating-runtime')
        %r{(?<hour>\d+)\s+hr\s+(?<min>\d+)} =~ rating_runtime.content
        begin
          Integer(hour) * 60 + Integer(min)
        rescue TypeError
          #puts rating_runtime
        end
      end
    end

  end
end
