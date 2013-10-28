require 'rails'
require 'active_record'
require 'paperclip'
ActiveRecord::Base.send(:include, Paperclip::Glue)
require 'homestead'
require Homestead::Engine.root.join('app', 'models', 'homestead', 'state')
require Homestead::Engine.root.join('app', 'models', 'homestead', 'office_status')
require Homestead::Engine.root.join('app', 'models', 'homestead', 'agent_status')
require Homestead::Engine.root.join('app', 'models', 'homestead', 'address')
require Homestead::Engine.root.join('app', 'models', 'homestead', 'listing_status')
require Homestead::Engine.root.join('app', 'models', 'homestead', 'listing_provider')
require Homestead::Engine.root.join('app', 'models', 'homestead', 'listing_photo')
require Homestead::Engine.root.join('app', 'models', 'homestead', 'listing')
require Homestead::Engine.root.join('app', 'models', 'homestead', 'property_type')
require Homestead::Engine.root.join('app', 'models', 'homestead', 'sub_property_type')
require Homestead::Engine.root.join('app', 'models', 'homestead', 'residential_property')
require Homestead::Engine.root.join('app', 'models', 'homestead', 'residential_listing')

require 'database_cleaner'

RSpec.configure do |config|
  config.before(:suite) do
    ActiveRecord::Base.establish_connection(
      YAML.load_file('db/config.yml')['test']
    ) unless ActiveRecord::Base.connected?

    Homestead::Engine.load_seed

    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
