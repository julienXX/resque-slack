require 'rubygems'
require 'resque'
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'resque-slack'))

RSpec.configure do |config|
  config.mock_framework = :rspec
end

# Require ruby files in support dir.
Dir[File.expand_path('spec/support/*.rb')].each { |file| require file }
