require 'spec_helper'

describe Fandango::Movie do

  specify '.parse parses RSS item into array of movie attribute hashes' do
    description_node = description_node_from_fixture_file('item.html')
    array = Fandango::Movie.parse(description_node)
    array.must_equal [
      {
        title: 'Abraham Lincoln: Vampire Hunter',
        id:    '141897',
      },
      {
        title: 'The Amazing Spider-Man 3D',
        id:    '141122',
      },
      {
        title: 'The Amazing Spider-Man',
        id:    '126975',
      },
    ]
  end

end
