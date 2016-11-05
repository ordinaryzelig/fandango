require "fandango/version"

require 'open-uri'
require 'nokogiri'

require 'fandango/api'

require 'fandango/theater'
require 'fandango/movie'
require 'fandango/showtime'

module Fandango

  module_function

  def movies_near(postal_code)
    MoviesNear.(postal_code)
  end

  def theater_showtimes(showtimes_link)
    TheaterShowtimes.(showtimes_link)
  end

end
