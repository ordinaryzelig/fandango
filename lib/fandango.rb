require "fandango/version"

require 'open-uri'
require 'nokogiri'

require 'fandango/parser'

module Fandango

  class << self

    def movies_near(postal_code, associate_id = '')
      raise ArgumentError, "postal code cannot be blank" if postal_code.nil? || postal_code == ''
      response = request(postal_code, associate_id)
      raise BadResponse.new(response) unless response.status.first == '200'
      source = response.read
      parse source
    end

    def movie_times_for_theater(theater_code, start_date, end_date, associate_id = '')
      raise ArgumentError, "theater code cannot be blank" if theater_code.nil? || theater_code == ''
      hash = {}
      theater = nil
      start_date.upto(end_date) do |date|
        response = request_times(theater_code, date, associate_id)
        raise BadResponse.new(response) unless response.status.first == '200'
        source = response.read
        if theater.nil?
          theater = parse_theater source
          theater[:id] = theater_code
          hash[:theater] = theater
        end
        hash[date.strftime("%Y/%m/%d")] = parse_times source
      end
      hash
    end

    def imdb_mappings(postal_code)
      raise ArgumentError, "postal code cannot be blank" if postal_code.nil? || postal_code == ''
      response = request_imdb_mappings(postal_code)
      raise BadResponse.new(response) unless response.status.first == '200'
      source = response.read
      parse_imdb_mappings source
    end

    def request(postal_code, associate_id = '')
      open(url_for_postal_code(postal_code, associate_id))
    end

#
# loop through dates
#

    def request_times(theater_code, date, associate_id = '')
      open(url_for_theater_code(theater_code, date, associate_id))
    end

    def request_imdb_mappings(postal_code)
      open(imdb_url_for_postal_code(postal_code))
    end

    # Given RSS source string, parse using Nokogiri.
    # Return hash of theaters and movies playing at each..
    def parse(source)
      Parser.parse(source)
    end

    def parse_times(source)
      Parser.parse_times(source)
    end

    def parse_theater(source)
      Parser.parse_theater(source)
    end

    def parse_imdb_mappings(source)
      Parser.parse_imdb_mappings(source)
    end

  private

    def url_for_postal_code(postal_code, associate_id)
      cleaned_postal_code = clean_postal_code(postal_code)
      associate_add_on = ''
      if (associate_id != '')
        associate_add_on = "?pid=#{associate_id}"
      end
      "http://www.fandango.com/rss/moviesnearme_#{cleaned_postal_code}.rss#{associate_add_on}"
    end

    # Remove spaces.
    def clean_postal_code(postal_code)
      postal_code.to_s.gsub(' ', '')
    end

    def formatted_date(time)
      return time.strftime("%m/%d/%Y")
    end

    def url_for_theater_code(theater_code, date, associate_id)
      cleaned_date = formatted_date(date)
      associate_add_on = ''
      if (associate_id != '')
        associate_add_on = "&wssaffid=#{associate_id}"
      end
      "http://www.fandango.com/a_#{theater_code}/theaterpage?date=#{cleaned_date}#{associate_add_on}"
    end

    def imdb_url_for_postal_code(postal_code)
      cleaned_postal_code = clean_postal_code(postal_code)
      "http://www.imdb.com/showtimes/cinemas/US/#{cleaned_postal_code}"
    end

  end

  class BadResponse < StandardError
    def initialize(response)
      super "Bad response:\n#{response.inspect}"
    end
  end

end
