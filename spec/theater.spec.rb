require_relative 'spec_helper'
require          'support/fixture_helpers'
require          'fandango/theater'

describe Fandango::Theater do

  include FixtureHelpers

  specify '.parse parses RSS item into Theater' do
    xml = fixture_file_content('movies_near_me_73142.rss')
    item_node = Nokogiri.XML(xml).at_css('item')
    theater = Fandango::Theater.parse(item_node)

    theater.name.must_equal           'AMC Quail Springs Mall 24'
    theater.id.must_equal             'aaktw'
    theater.address.must_equal        '2501 West Memorial Oklahoma City, OK 73134'
    theater.postal_code.must_equal    '73134'
    theater.showtimes_link.must_equal 'http://www.fandango.com/amcquailspringsmall24_aaktw/theaterpage?wssaffid=11836&wssac=123'
  end

end
