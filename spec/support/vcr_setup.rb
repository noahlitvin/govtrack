VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr'
  # HTTP request service
  c.register_request_matcher :uri do |request_1, request_2|
    # debugger # so you can inspect the requests here
    request_1.uri == request_2.uri
  end
  # c.hook_into :fakeweb
  c.stub_with :fakeweb
#   c.default_cassette_options = {:record => :new_episodes}
end