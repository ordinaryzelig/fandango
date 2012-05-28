require 'spec_helper'

describe Fandango do

  describe '.movies_near' do

    it 'returns hash of theaters and movies playing at each' do
      VCR.use_cassette 'movies_near_me_73142' do
        array = Fandango.movies_near(73142)
        fixture_yaml = fixture_file_content('movies_near_me_73142.yaml')
        array.to_yaml.must_equal fixture_yaml
      end
    end

    it 'raises error if postal code blank' do
      proc { Fandango.movies_near('') }.must_raise(ArgumentError)
    end

    it 'raises error if status code is not 200' do
      response = MiniTest::Mock.new
      response.expect(:status, ['500', 'not ok'])
      Fandango.stub(:request, response) do
        proc { Fandango.movies_near('does not matter') }.must_raise(Fandango::BadResponse)
      end
    end

  end

  specify '.request makes http request and returns response' do
    VCR.use_cassette 'movies_near_me_73142' do
      source = Fandango.request(73142).read
      fixture_source = fixture_file_content('movies_near_me_73142.rss').chomp
      source.must_equal fixture_source
    end
  end

  specify '.clean_postal_code removes spaces from postal code' do
    Fandango.send(:clean_postal_code, 'ABC 123').must_equal 'ABC123'
  end

end
