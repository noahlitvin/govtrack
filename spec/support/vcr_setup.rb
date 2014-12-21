VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr'
  # HTTP request service
  c.hook_into :fakeweb
#   c.default_cassette_options = {:record => :new_episodes}
end