require 'govtrack'
require 'rspec'
require 'webmock'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr'
  # HTTP request service
  c.hook_into :webmock
  c.configure_rspec_metadata!                       # here, we can use :vcr to record a cassette
  c.allow_http_connections_when_no_cassette = true  # this way, we don't have to use vcr
  c.default_cassette_options = {:record => :new_episodes}
end

# RSpec.configure do |config|
#   config.mock_with :rspec do |c|
#     c.syntax = [:should, :expect]
#   end
# end

# super helpful: https://gist.github.com/myronmarston/2377461