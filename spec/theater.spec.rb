require_relative 'spec_helper'
require          'support/fixture_helpers'

module Fandango
  describe Theater do

    include FixtureHelpers

    specify '.parse parses RSS item into Theater' do
      xml = fixture_file_content('movies_near_me_73142.rss')
      item_node = Nokogiri.XML(xml).at_css('item')
      theater = Theater.parse(item_node)

      theater.must_equal(
        name:           'AMC Quail Springs Mall 24',
        id:             'aaktw',
        address:        '2501 West Memorial Oklahoma City, OK 73134',
        postal_code:    '73134',
        showtimes_link: 'http://www.fandango.com/amcquailspringsmall24_aaktw/theaterpage?wssaffid=11836&wssac=123',
        movies: [
          {:title=>"Abraham Lincoln: Vampire Hunter", :id=>"141897"},
          {:title=>"The Amazing Spider-Man 3D", :id=>"141122"},
          {:title=>"The Amazing Spider-Man", :id=>"126975"},
          {:title=>"The Amazing Spider-Man: An IMAX 3D Experience", :id=>"153829"},
          {:title=>"Battleship", :id=>"130096"},
          {:title=>"The Best Exotic Marigold Hotel", :id=>"147777"},
          {:title=>"Brave", :id=>"136016"},
          {:title=>"Bully", :id=>"145958"},
          {:title=>"Chernobyl Diaries", :id=>"152960"},
          {:title=>"Chimpanzee", :id=>"116882"},
          {:title=>"Dark Shadows", :id=>"147176"},
          {:title=>"The Dictator", :id=>"145763"},
          {:title=>"Happiest Baby and Happiest Toddler Live With Dr. Karp", :id=>"154921"},
          {:title=>"The Hunger Games", :id=>"136944"},
          {:title=>"The Lucky One", :id=>"145457"},
          {:title=>"Madagascar 3: Europe's Most Wanted 3D", :id=>"151457"},
          {:title=>"Marvel's The Avengers", :id=>"30154"},
          {:title=>"Marvel's The Avengers 3D", :id=>"151545"},
          {:title=>"Men in Black III", :id=>"135737"},
          {:title=>"Men in Black III 3D", :id=>"147264"},
          {:title=>"Men in Black III: An IMAX 3D Experience", :id=>"148659"},
          {:title=>"National Theater Live: Frankenstein (Original Casting)", :id=>"137637"},
          {:title=>"National Theater Live: Frankenstein (Reverse Casting)", :id=>"142883"},
          {:title=>"The Pirates! Band of Misfits", :id=>"146664"},
          {:title=>"Prometheus 3D", :id=>"152981"},
          {:title=>"Prometheus: An IMAX 3D Experience", :id=>"153676"},
          {:title=>"Ratatouille", :id=>"98260"},
          {:title=>"Snow White and the Huntsman", :id=>"141533"},
          {:title=>"Ted", :id=>"136691"},
          {:title=>"The Tempest Starring Christopher Plummer", :id=>"155187"},
          {:title=>"That's My Boy", :id=>"149081"},
          {:title=>"Think Like a Man", :id=>"147732"},
          {:title=>"Toy Story 3", :id=>"124782"},
          {:title=>"Up", :id=>"114055"},
          {:title=>"WALL-E", :id=>"102903"},
          {:title=>"What to Expect When You're Expecting", :id=>"120322"},
        ],
      )
    end

  end
end
