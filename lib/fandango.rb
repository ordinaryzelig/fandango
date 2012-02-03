require "fandango/version"
require 'feedzirra'

require 'fandango/parser'

module Fandango

  class << self

    def movies_near(postal_code)
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
      Feedzirra::Feed.fetch_and_parse("http://www.fandango.com/rss/moviesnearme_#{postal_code}.rss")
    end

  end

end
