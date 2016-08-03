require_relative 'spec_helper'
require          'support/fixture_helpers'

describe Fandango::Movie do

  include FixtureHelpers

  specify '.parse parses RSS item into array of Movies' do
    xml = fixture_file_content('movies_near_me_73142.rss')
    cdata = Nokogiri.XML(xml).at_css('item').at_css('description')
    description_node = Nokogiri.HTML(cdata.content)
    movies = Fandango::Movie.parse(description_node)

    movies.size.must_equal 36

    movies_atts = movies[0, 3].map { |movie| {title: movie.title, id: movie.id} }
    movies_atts.must_equal [
      {
        title: 'Abraham Lincoln: Vampire Hunter',
        id:    '141897',
      },
      {
        title: 'The Amazing Spider-Man 3D',
        id:    '141122',
      },
      {
        title: 'The Amazing Spider-Man',
        id:    '126975',
      },
    ]
  end

end
