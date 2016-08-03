module Fandango
  autoload :MoviesNear, 'fandango/api/movies_near'

  module API

    class BadResponse < StandardError
      def initialize(response)
        super "Bad response:\n#{response.inspect}"
      end
    end

  end
end
