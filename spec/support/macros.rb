module Macros

  def fixture_file(file_name)
    File.open("spec/support/fixtures/#{file_name}")
  end

  # Stub Feedzirra response with stored fixture file content.
  # This is a workaround because VCR doesn't support Feedzirra yet.
  # File contents cannot be obtained from Safari because it translates
  # it into HTML. Use Firefox to get original raw source.
  def stub_feed(file_name)
    Curl::Easy.expects(:new).never
    file_content = fixture_file(file_name).read
    feed = Feedzirra::Parser::RSS.parse(file_content)
    Feedzirra::Feed.expects(:fetch_and_parse).returns(feed)
  end

end
