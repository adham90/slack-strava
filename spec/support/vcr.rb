require 'vcr'
require 'webmock/rspec'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures'
  config.hook_into :webmock
  # config.default_cassette_options = { record: :new_episodes }
  config.configure_rspec_metadata!
  config.ignore_localhost = true
  config.before_record do |i|
    i.request.headers['Authorization'] = ['Bearer token'] if i.request.headers.key?('Authorization')
    i.response.body.force_encoding('UTF-8')
  end
end
