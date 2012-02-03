class Fandango::Parser

  # Cache entry.
  # Define entry.summary_doc as Nokogiri HTML document.
  # Both theater and movie parsers use summary, and we only want to use Nokogiri once per entry.
  def initialize(entry)
    @entry = entry
    @entry.define_singleton_method(:summary_doc) do
      @summary_doc ||= Nokogiri.HTML(summary)
    end
  end

  def parse_theater
    Theater.new(@entry).parse
  end

  def parse_movies
    Movie.new(@entry).parse
  end

end

require 'fandango/parsers/theater'
require 'fandango/parsers/movie'
