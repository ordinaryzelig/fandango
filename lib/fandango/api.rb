module Fandango
  autoload :MoviesNear,       'fandango/api/movies_near'
  autoload :TheaterShowtimes, 'fandango/api/theater_showtimes'

  module API

    class BadResponse < StandardError
      def initialize(response)
        super "Bad response:\n#{response.inspect}"
      end
    end

  end
end
