module Fandango
  module Showtime

    module_function

    def parse(node)
      {
        datetime: parse_datetime(node),
      }
    end

    def parse_datetime(node)
      datetime_str = node.at_css('time').attr('datetime')
      DateTime.parse(datetime_str)
    end

  end
end
