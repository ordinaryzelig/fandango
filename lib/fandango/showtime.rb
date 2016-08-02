require 'fandango/movie'

module Fandango
  class Showtime

    class << self

      def parse_all(html)
        doc = Nokogiri.HTML(html)
        doc.css('.showtimes-movie-container').map do |movie_node|
          movie = MovieObj.parse(movie_node)
          movie.showtimes =
            movie_node.at_css('.showtimes-times').css('a').map do |showtime_node|
              parse(showtime_node)
            end
          movie
        end
      end

      def parse(node)
        showtime = new
        showtime.datetime = DateTime.parse(node.at_css('time').attr('datetime'))
        showtime
      end

    end

    attr_accessor :datetime

  end

  class MovieObj

    class << self

      def parse(movie_node)
        movie = new
        movie.title = movie_node.at_css('.showtimes-movie-title').content
        movie
      end

    end

    attr_accessor :title
    attr_accessor :showtimes

  end
end
