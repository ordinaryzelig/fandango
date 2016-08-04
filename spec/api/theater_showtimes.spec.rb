require_relative '../spec_helper'
require          'support/vcr'
require          'support/fixture_helpers'

module Fandango
  describe TheaterShowtimes do

    include FixtureHelpers

    it 'requests and parses showtimes for given URL into Movies with Showtimes' do
      VCR.use_cassette 'theater_showtimes_amcquailspringsmall24' do
        url = 'http://www.fandango.com/amcquailspringsmall24_aaktw/theaterpage?wssaffid=11836&wssac=123'

        movies = Fandango.theater_showtimes(url)

        movies_yaml =
          movies.map do |movie|
            {
              title:     movie.title,
              id:        movie.id,
              runtime:   movie.runtime,
              showtimes: movie.showtimes.map do |showtime|
                {
                  movie_id: showtime.movie.id,
                  datetime: showtime.datetime,
                }
              end
            }
          end
          .to_yaml

        fixture_yaml = fixture_file_content('theater_showtimes_amcquailspringsmall24.yml')
        movies_yaml.must_equal fixture_yaml
      end
    end

  end
end
