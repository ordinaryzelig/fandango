require_relative 'spec_helper'
require          'support/fixture_helpers'

module Fandango
  describe Showtime do

    include FixtureHelpers

    specify '.parse parses node into Showtime' do
      html = fixture_file_content('showtimes_amcquailspringsmall24_aaktw_2016_08_01.html')
      node = Nokogiri.HTML(html).at_css('.showtimes-movie-container')

      showtime = Showtime.parse(node)

      showtime.datetime.must_equal DateTime.parse('2016-08-01T11:30:00-05:00')
    end

    it 'considers preview time to calculate feature_start_time, feature_end_time' do
      movie             = Movie.new
      movie.runtime     = 120
      showtime          = Showtime.new
      showtime.datetime = DateTime.new(2016, 8, 4, 12)
      movie.showtimes   = [showtime]

      showtime.feature_start_time.must_equal DateTime.new(2016, 8, 4, 12, 20)
      showtime.feature_end_time  .must_equal DateTime.new(2016, 8, 4, 14, 20)
    end

  end
end
