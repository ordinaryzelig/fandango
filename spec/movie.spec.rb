require_relative 'spec_helper'
require          'support/fixture_helpers'

describe Fandango::Movie do

  include FixtureHelpers

  specify '.parse parses RSS item into array of Movies' do
    xml = fixture_file_content('movies_near_me_73142.rss')
    cdata = Nokogiri.XML(xml).at_css('item').at_css('description')
    li = Nokogiri.HTML(cdata.content).at_css('li')

    movie = Fandango::Movie.parse(li)

    movies_atts = %i[title id].each_with_object({}) do |att, atts|
      atts[att] = movie.public_send(att)
    end
    movies_atts.must_equal(
      title: 'Abraham Lincoln: Vampire Hunter',
      id:    '141897',
    )
  end

end
