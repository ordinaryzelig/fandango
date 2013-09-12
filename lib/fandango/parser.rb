require 'fandango/movie'
require 'fandango/theater'

module Fandango
  class Parser

    class << self

      def parse(source)
        parser = new(source)
        parser.parse
      end

      def parse_times(source)
        parser = new(source)
        parser.parse_times
      end

      def parse_theater(source)
        parser = new(source)
        parser.parse_theater
      end

      def parse_imdb_mappings(source)
        parser = new(source)
        parser.parse_imdb_mappings
      end

      # Description content is wrapped in CDATA.
      # Parse it and return a parsed Nokogiri node.
      def parse_description(item_node)
        cdata = item_node.at_css('description')
        Nokogiri::HTML(cdata.content)
      end

    end

    def initialize(source)
      @source = source
    end

    def parse
      @doc = Nokogiri.XML(@source)
      @doc.css('item').map do |item_node|
        hash = {}
        description_node = self.class.parse_description(item_node)
        hash[:theater] = Theater.parse(item_node, description_node)
        hash[:movies] = Movie.parse(description_node)
        hash
      end
    end

    def parse_theater
      @doc = Nokogiri.HTML(@source)
      hash = {}
      # theater info
      theater_details = @doc.css("div[class=info] div[class=adr]")
      hash[:name] = theater_details.css("span[class=org]").text
      hash[:address] = theater_details.css("span[class=street-address]").text
      hash[:locality] = theater_details.css("span[class=locality]").text
      hash[:region] = theater_details.css("span[class=region]").text
      hash[:postal] = theater_details.css("span[class=postal-code]").text
      hash
    end

    def parse_times
      @doc = Nokogiri.HTML(@source)
      @doc.css("div[class=times] a[class=showtime_itr]").map do |times_node|
        hash = {}
        ticket_url = times_node["href"]
        hash[:ticket_url] = ticket_url
        hash[:time] = times_node.css("span[class=showtime_pop]").text
        hash[:movie_id] = ticket_url.match(%r{([&?]|%3f|%26)mid=(?<id>\d+)})[:id]
        hash[:row_count] = ticket_url.match(%r{([&?]|%3f|%26)row_count=(?<id>\d+)})[:id]
        hash
      end
    end

    def parse_imdb_mappings
        @doc = Nokogiri.HTML(@source)
        @doc.css("div[id=get_tickets_button] a").map do |mapping_node|
        hash = {}
        ticket_url = mapping_node["href"]
        hash[:movie_title] = mapping_node["data-title"]
        hash[:imdb_id] = mapping_node["data-titleid"].match(%r{tt(?<id>\d+)})[:id]
        hash[:movie_id] = ticket_url.match(%r{([&?]|%3f|%26|&amp;)mid=(?<id>\d+)})[:id]
        hash[:theater_id] = ticket_url.match(%r{([&?]|%3f|%26|&amp;)tid=(?<id>[a-zA-Z]+)})[:id]
        hash
      end
    end

  end
end
