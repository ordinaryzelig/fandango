require "fandango/version"
require 'feedzirra'

require 'fandango/parser'

module Fandango

  class << self

    def movies_near(postal_code)
      raise ArgumentError, "postal code cannot be blank" if postal_code.nil? || postal_code == ''
      feed = fetch_and_parse(postal_code)
      feed.entries.map do |entry|
        parser = Parser.new(entry)
        hash = {}
        hash[:theater] = parser.parse_theater
        hash[:movies] = parser.parse_movies
        hash
      end
    end

    private

    def fetch_and_parse(postal_code)
      cleaned_postal_code = postal_code.to_s.gsub(' ', '')
      feed = Feedzirra::Feed.fetch_and_parse("http://www.fandango.com/rss/moviesnearme_#{cleaned_postal_code}.rss")
      raise BadResponse.new(feed) unless feed.respond_to?(:entries)
      feed
    end

  end

  class BadResponse < StandardError
    def initialize(response)
      super "Bad response: #{response.inspect}"
    end
  end

end
