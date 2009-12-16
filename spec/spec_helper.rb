begin
  # Load the bundler environment from #{Merb.root}/gems/environment.rb
  require File.join(File.dirname(__FILE__), "..", "gems", "environment")
rescue LoadError
  # Default to using system rubygems if there's no bundle detected
  require "rubygems"
end

require "spec" # Satisfies Autotest and anyone else not using the Rake tasks
require "merb-core"

# this loads all plugins required in your init file so don't add them
# here again, Merb will do it for you
Merb.start_environment(:testing => true, :adapter => 'runner', :environment => ENV['MERB_ENV'] || 'test')

Spec::Runner.configure do |config|
  config.include(Merb::Test::ViewHelper)
  config.include(Merb::Test::RouteHelper)
  config.include(Merb::Test::ControllerHelper)
  
  config.before(:all) do
    DataMapper.auto_migrate! if Merb.orm == :datamapper
  end
  
end
