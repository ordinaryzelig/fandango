require_relative 'spec_helper'
require          'support/fixture_helpers'

module Fandango
  describe Movie do

    include FixtureHelpers

    specify '.parse parses RSS item into array of movie atts' do
      xml = fixture_file_content('movies_near_me_73142.rss')
      cdata = Nokogiri.XML(xml).at_css('item').at_css('description')
      li = Nokogiri.HTML(cdata.content).at_css('li')

      movies = Movie.parse(li)

      movies.must_equal(
        title: 'Abraham Lincoln: Vampire Hunter',
        id:    '141897',
      )
    end

  end
end
