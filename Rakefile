require 'active_record'
require 'logger'

task :default => 'db:migrate'

namespace :db do
  MIGRATIONS_DIR = 'db/migrate'

  desc 'Migrate the database'
  task :migrate => :environment do
    ActiveRecord::Migrator.migrate(MIGRATIONS_DIR, ENV["VERSION"] ? ENV["VERSION"] : nil)
  end

  desc 'Roll back the database schema to previous version'
  task :rollback => :environment do
    ActiveRecord::Migrator.rollback(MIGRATIONS_DIR, ENV["STEP"] ? ENV["STEP"] : 1)
  end

  task :environment do
    ActiveRecord::Base.establish_connection(YAML.load(File.open('config/database.yml')))
    ActiveRecord::Base.logger = Logger.new(File.open('log/migration.log', 'a'))
  end
end
