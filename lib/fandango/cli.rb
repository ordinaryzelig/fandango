require 'awesome_print'

module Fandango
  class CLI

    HTML = File.read('spec/support/fixtures/showtimes_amcquailspringsmall24_aaktw_2016_08_01.html')
    MOVIES = TheaterShowtimes::Parser.(HTML)

    def initialize
      @movies_left = MOVIES.dup
      @selected_showtimes = []
    end

    def run
      while @movies_left.any? && next_showtimes.any?
        showtime = prompt_for_showtime
        @selected_showtimes << showtime
        @movies_left.delete(showtime.movie)
        puts
      end

      @selected_showtimes.each do |showtime|
        puts formatted_showtime(showtime)
      end
    end

  private

    def prompt_for_showtime
      showtimes = next_showtimes

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

  end
end
