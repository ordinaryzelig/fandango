require 'pathname'

module SpecHelpers

  def fixture_file(file_name)
    fixtures_path = Pathname.new('./spec/support/fixtures/')
    File.open(fixtures_path + file_name)
  end

  def fixture_file_content(file_name)
    fixture_file(file_name).read
  end

  def item_node_from_fixture_file(file_name)
    item_html = fixture_file_content('item.html')
    Nokogiri.XML(item_html).at_css('item')
  end

  def description_node_from_fixture_file(file_name)
    Fandango::Parser.parse_description(item_node_from_fixture_file(file_name))
  end

end

MiniTest::Unit::TestCase.send :include, SpecHelpers if defined?(MiniTest)
