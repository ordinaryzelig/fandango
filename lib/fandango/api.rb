module Fandango
  autoload :MoviesNear,       'fandango/api/movies_near'
  autoload :TheaterShowtimes, 'fandango/api/theater_showtimes'

  module API

    module_function

    def conn
      @conn ||= Faraday.new do |conf|
        conf.adapter Faraday.default_adapter
      end
    end

    def get_cookie
      conn.get 'https://www.fandango.com/'
    end

    class BadResponse < StandardError
      def initialize(response)
        super "Bad response (#{response.status})\n#{response.body}"
      end
    end

  end
end
