require 'pg_foreign_keys'
require 'postgres_ext'
require 'factory_girl'
require 'pry'

if ENV['DEBUG']
  require 'logger'
  ActiveRecord::Base.logger = Logger.new(STDOUT)
end

db_config = {
  adapter:  'postgresql',
  encoding: 'utf8',
  database: 'pg_foreign_keys',
  host:     'localhost',
  username: 'ubuntu',
  password: 'password'
}

ActiveRecord::Base.establish_connection(db_config.merge(:database => 'postgres'))
ActiveRecord::Base.connection.drop_database(db_config[:database]) rescue nil
ActiveRecord::Base.connection.create_database(db_config[:database], { encoding: 'utf8' })
ActiveRecord::Base.establish_connection(db_config)

# load support
load File.dirname(__FILE__) + '/support/factories.rb'
load File.dirname(__FILE__) + '/support/schema.rb'
load File.dirname(__FILE__) + '/support/models.rb'

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
  config.treat_symbols_as_metadata_keys_with_true_values = true
end

def clean_database!
  [Klass, Student, Teacher].each do |model|
    model.delete_all
  end
end