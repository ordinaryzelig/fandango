require_relative '../spec_helper'
require          'support/vcr'
require          'support/fixture_helpers'

describe Fandango::TheaterShowtimes do

  include FixtureHelpers

  it 'requests and parses showtimes for given URL into Movies with Showtimes' do
    VCR.use_cassette 'theater_showtimes_amcquailspringsmall24' do
      url = 'http://www.fandango.com/amcquailspringsmall24_aaktw/theaterpage?wssaffid=11836&wssac=123'

      movies = Fandango.theater_showtimes(url)

      fixture_yaml = fixture_file_content('theater_showtimes_amcquailspringsmall24.yml')
      movies.to_yaml.must_equal fixture_yaml
    end
  end

end
