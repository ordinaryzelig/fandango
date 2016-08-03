module Fandango
  class Showtime

    class << self

      def parse(node)
        showtime = new
        datetime_str = node.at_css('time').attr('datetime')
        showtime.datetime = DateTime.parse(datetime_str)
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
