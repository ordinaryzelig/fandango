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

  def theater_showtimes(showtimes_link_or_options)
    if showtimes_link_or_options.is_a?(Hash)
      TheaterShowtimes.by_id_and_date(showtimes_link_or_options)
    else
      TheaterShowtimes.(showtimes_link_or_options)
    end
  end

end
