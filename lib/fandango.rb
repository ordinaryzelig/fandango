require "fandango/version"

require 'open-uri'
require 'nokogiri'

require 'fandango/parser'

module Fandango

  class << self

    def movies_near(postal_code)
      raise ArgumentError, "postal code cannot be blank" if postal_code.nil? || postal_code == ''
      response = request(postal_code)
      raise BadResponse.new(response) unless response.status.first == '200'
      source = response.read
      parse source
    end

    def request(postal_code)
      open(url_for_postal_code(postal_code))
    end

    # Given RSS source string, parse using Nokogiri.
    # Return hash of theaters and movies playing at each..
    def parse(source)
      Parser.parse(source)
    end

  private

    def url_for_postal_code(postal_code)
      cleaned_postal_code = clean_postal_code(postal_code)
      "http://www.fandango.com/rss/moviesnearme_#{cleaned_postal_code}.rss"
    end

    # Remove spaces.
    def clean_postal_code(postal_code)
      postal_code.to_s.gsub(' ', '')
    end

  end

  class BadResponse < StandardError
    def initialize(response)
      super "Bad response:\n#{response.inspect}"
    end
  end

end
