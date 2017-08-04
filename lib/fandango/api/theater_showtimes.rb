module Fandango
  module TheaterShowtimes

    BASE_URL = 'https://www.fandango.com/theater_%{theater_id}/theaterpage?date=%{date}'

    module_function

    def call(showtimes_link)
      response = request(showtimes_link)
      raise BadResponse.new(response) unless response.status.first == '200'

      html = response.read
      Parser.(html)
    end

    def by_id_and_date(theater_id:, date: Date.today)
      url = BASE_URL % {:theater_id => theater_id, :date => date}
      call url
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
