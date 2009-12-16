begin
  # Load the bundler environment from #{Merb.root}/gems/environment.rb
  require File.join(File.dirname(__FILE__), "gems", "environment")
rescue LoadError
  # Default to using system rubygems if there's no bundle detected
  require "rubygems"
end

require 'merb-core'

Merb::Config.setup(:merb_root   => File.expand_path(File.dirname(__FILE__)), 
                   :environment => ENV['RACK_ENV'])
Merb.environment = Merb::Config[:environment]
Merb.root = Merb::Config[:merb_root]
Merb::BootLoader.run 
run Merb::Rack::Application.new