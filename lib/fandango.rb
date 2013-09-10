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
      start_date.upto(end_date) do |date|
        response = request_times(theater_code, date, associate_id)
        raise BadResponse.new(response) unless response.status.first == '200'
        source = response.read
        hash[date.strftime("%m/%d/%Y")] = parse_times source
      end
      hash
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

    # Given RSS source string, parse using Nokogiri.
    # Return hash of theaters and movies playing at each..
    def parse(source)
      Parser.parse(source)
    end

    def parse_times(source)
      Parser.parse_times(source)
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

  end

  class BadResponse < StandardError
    def initialize(response)
      super "Bad response:\n#{response.inspect}"
    end
  end

end
