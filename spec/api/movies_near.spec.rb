require_relative '../spec_helper'
require          'support/vcr'
require          'support/fixture_helpers'

module Fandango
  describe MoviesNear do

    include FixtureHelpers

    it 'returns Theaters and Movies playing at each' do
      VCR.use_cassette 'movies_near_me_73142' do
        theaters = Fandango.movies_near(73142)
        theaters_hash = theaters.map do |theater|
          {
            name:        theater.name,
            id:          theater.id,
            address:     theater.address,
            postal_code: theater.postal_code,
            movies: theater.movies.map do |movie|
              {
                title: movie.title,
                id:    movie.id,
              }
            end,
          }
        end
        fixture_yaml = fixture_file_content('movies_near_me_73142.yml')
        theaters_hash.to_yaml.must_equal fixture_yaml
      end
    end

    it 'raises error if status code is not 200' do
      response = MiniTest::Mock.new
      response.expect(:status, ['500', 'not ok'])

      MoviesNear.stub(:request, response) do
        proc do
          Fandango.movies_near('_')
        end.must_raise(MoviesNear::BadResponse)
      end
    end

  end
end
