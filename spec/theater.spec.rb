require 'spec_helper'

describe Fandango::Theater do

  specify '.parse parses RSS item into array of movie attribute hashes' do
    item_node = item_node_from_fixture_file('item.html')
    hash = Fandango::Theater.parse(item_node)
    hash.must_equal({
      name:        'AMC Quail Springs Mall 24',
      id:          'aaktw',
      address:     '2501 West Memorial Oklahoma City, OK 73134',
      postal_code: '73134',
    })
  end

end
