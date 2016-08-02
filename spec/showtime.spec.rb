require_relative 'spec_helper'
require          'support/fixture_helpers'
require          'fandango/showtime'

module Fandango

  describe Showtime do

    include FixtureHelpers

    specify '.parse parses HTML tag into array of Showtime objects' do
      html = fixture_file_content('showtimes_amcquailspringsmall24_aaktw_2016_08_01.html')
      movies = Showtime.parse_all(html)
      fixture_yaml = fixture_file_content('showtimes_amcquailspringsmall24_aaktw_2016_08_01.yml')
      movies.to_yaml.must_equal fixture_yaml
    end

  end

end
