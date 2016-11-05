module Fandango
  module TheaterShowtimes

    module_function

    def call(showtimes_link)
      response = request(showtimes_link)
      raise BadResponse.new(response) unless response.status.first == '200'

      html = response.read
      Parser.(html)
    end

    def request(showtimes_link)
      open(showtimes_link)
    end

    module Parser

      module_function

      def call(html)
        doc = Nokogiri.HTML(html)
        doc.css('.showtimes-movie-container').map do |movie_node|
          movie = Movie.parse(movie_node)
          movie[:showtimes] =
            movie_node.at_css('.showtimes-times').css('a').map do |showtime_node|
              Showtime.parse(showtime_node)
            end
          movie
        end
      end

    end

  end

  class BadResponse < API::BadResponse; end

end
