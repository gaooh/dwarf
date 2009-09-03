$KCODE = 'u'
# Be sure to restart your web server when you modify this file.

# Uncomment below to force Rails into production mode when 
# you don't control web/app server and can't set it the proper way
# ENV['RAILS_ENV'] ||= 'production'

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '1.2.6' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here
  
  # Skip frameworks you're not going to use (only works if using vendor/rails)
  # config.frameworks -= [ :action_web_service, :action_mailer ]

  # Only load the plugins named here, by default all plugins in vendor/plugins are loaded
  # config.plugins = %W( exception_notification ssl_requirement )

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Force all environments to use the same logger level 
  # (by default production uses :info, the others :debug)
  # config.log_level = :debug

  # Use the database for sessions instead of the file system
  # (create the session table with 'rake db:sessions:create')
  # config.action_controller.session_store = :active_record_store

  # Use SQL instead of Active Record's schema dumper when creating the test database.
  # This is necessary if your schema can't be completely dumped by the schema dumper, 
  # like if you have constraints or database-specific column types
  # config.active_record.schema_format = :sql

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector

  # Make Active Record use UTC-base instead of local time
  # config.active_record.default_timezone = :utc
  
  # See Rails::Configuration for more options
end

# Add new inflection rules using the following format 
# (all these examples are active by default):
# Inflector.inflections do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
# end

# Add new mime types for use in respond_to blocks:
# Mime::Type.register "text/richtext", :rtf
# Mime::Type.register "application/x-mobile", :mobile

# Include your application configuration below

# for gruff
require 'gruff'

# for twitter
require 'rubygems'
gem 'twitter4r', '0.3.0'
require 'twitter'
require 'twitter/console'


Twitter::Client.configure do |conf|
  conf.protocol = :ssl
  conf.host = 'twitter.com'
  conf.port = 443

  conf.user_agent = 'co-bit3'
  conf.application_name = 'co-bit3'
  conf.application_version = 'v1.0.0'
  conf.application_url = 'http://co-bit3.drecom.jp'

  # Twitter (not Twitter4R) will have to setup a source ID for your application to get it
  # recognized by the web interface according to your preferences.
  # To see more information how to go about doing this, please referen to the following thread:
  # http://groups.google.com/group/twitter4r-users/browse_thread/thread/c655457fdb127032
  conf.source = "your-source-id-that-twitter-recognizes"

end

ActionController::Base.perform_caching = true
ActionController::Base.page_cache_directory = "#{RAILS_ROOT}/public/system/cache/"
ActionController::Base.fragment_cache_store = ActionController::Caching::Fragments::FileStore.new("#{RAILS_ROOT}/public/system/cache/fragments/")
