require 'awesome_print'

module Fandango
  class CLI

    HTML = File.read('spec/support/fixtures/showtimes_amcquailspringsmall24_aaktw_2016_08_01.html')
    #MOVIES = TheaterShowtimes::Parser.(HTML)
    MOVIES = [
      {
        title: 'Cafe Society',
        runtime: 96,
        showtimes: ['14:10'],
      },
      {
        title: 'Jason Bourne',
        runtime: 123,
        showtimes: ['15:00', '16:00', '17:00'],
      },
      {
        title: 'Star Trek',
        runtime: 122,
        showtimes: ['17:30', '18:25'],
      },
    ].map do |atts|
      movie = Movie.new
      movie.title = atts.fetch(:title)
      movie.runtime = atts.fetch(:runtime)
      movie.showtimes = atts.fetch(:showtimes).map do |time|
        showtime = Showtime.new
        showtime.datetime = DateTime.parse(time)
        showtime
      end
      movie
    end

    def initialize
      @movies_left = MOVIES.dup
      @selected_showtimes = []
    end

    def run
      print_all

      while @movies_left.any?
        showtimes = next_showtimes
        break if showtimes.empty?

        showtime = prompt_for_showtime(showtimes)
        @selected_showtimes << showtime
        @movies_left.delete(showtime.movie)
        puts
      end

      @selected_showtimes.each do |showtime|
        puts formatted_showtime(showtime)
      end
    end

  private

    def prompt_for_showtime(showtimes)
      puts "Pick a movie:"

      showtimes.each_with_index do |showtime, idx|
        puts "#{idx + 1}. #{formatted_showtime(showtime)}"
      end
      int = Integer(gets)

      showtimes.fetch(int - 1)
    end

    def next_showtimes
      @movies_left
        .map do |movie|
          movie.next_showtime(next_earliest_start_datetime)
        end
        .compact
        .sort
    end

    def next_earliest_start_datetime
      if @selected_showtimes.any?
        @selected_showtimes.last.feature_end_time
      else
        @movies_left.first.showtimes.first.datetime.to_date
      end
    end

    def l(obj)
      case obj
      when DateTime
        obj.strftime('%H:%M')
      else
        obj
      end
    end

    def formatted_showtime(showtime)
      "#{l(showtime.datetime)} #{showtime.movie.title}"
    end

    def print_all
      @movies_left.each do |movie|
        puts "#{movie.title} (#{movie.runtime}m)"
        puts movie
          .showtimes
          .map { |st| l(st.datetime) }
          .join(' ,')
        puts
      end
    end

  end
end
