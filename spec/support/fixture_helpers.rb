require 'pathname'

module FixtureHelpers

  def fixture_file(file_name)
    fixtures_path = Pathname.new('./spec/support/fixtures/')
    File.open(fixtures_path + file_name)
  end

  def fixture_file_content(file_name)
    fixture_file(file_name).read
  end

end
