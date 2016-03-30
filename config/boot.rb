# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)
ENV['AWS_REGION'] = 'us-west-2'

require 'bundler/setup' if File.exist?(ENV['BUNDLE_GEMFILE'])
