require 'spec_helper'

describe Fandango do

  describe '.movies_near' do

    it 'returns hash of theaters and movies playing at each' do
      stub_feed 'movies_near_me_73142.rss'
      array = Fandango.movies_near(73142)
      array.size.must_equal 11
      hash = array.first
      # Check theater attributes.
      theater_atts = hash[:theater]
      theater_atts[:name].must_equal 'Northpark 7'
      theater_atts[:id].must_equal 'aaicu'
      theater_atts[:address].must_equal '12100 N. May Ave Oklahoma City, OK 73120'
      theater_atts[:postal_code].must_equal '73120'
      # Check movie attributes.
      movies_atts = hash[:movies]
      movies_atts.size.must_equal 8
      movies_atts.first[:title].must_equal 'Happy Feet Two'
    end

    it 'raises error if postal code nil' do
      proc { Fandango.movies_near(nil) }.must_raise(ArgumentError)
    end

    it 'raises BadResponse unless feedzirra feed responds to entries' do
      Feedzirra::Feed.expects(:fetch_and_parse).returns(0)
      proc { Fandango.movies_near(123) }.must_raise(Fandango::BadResponse)
    end

    it 'removes spaces from postal code' do
      feed = Object.new
      feed.stubs(:entries).returns([])
      url = 'http://www.fandango.com/rss/moviesnearme_ABC123.rss'
      Feedzirra::Feed.expects(:fetch_and_parse).with(url).returns(feed)
      Fandango.send(:fetch_and_parse, 'ABC 123')
    end

  end

end
