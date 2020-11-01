require 'rails/generators'
require 'rails/generators/migration'

module Checkmarks
  class MigrationGenerator < Rails::Generators::Base
    include Rails::Generators::Migration

    desc "Generates migration for checkmarks" 
    
    # __dir__ is a Kernel function that is implemented as File.dirname(File.realpath(__FILE__)), thus giving you the absolute_path of the directory of the current file
    source_root File.expand_path('templates', __dir__)
    
    # class_method on Rails::Generators::Migration. Must be manually implemented, otherwise NotImplementedError raised.
    def self.next_migration_number(dirname)
      # Checks ActiveRecord::Base cattr_reader/cattr_accessor for the timestamped_migration value, if true uses Time as migration number
      if ActiveRecord::Base.timestamped_migrations
        # Default Rails migration number format
        Time.now.utc.strftime("%Y%m%d%H%M%S")
      else
        # String formatting with %, to ensure that migration number is 3 digits - e.g. "%.3d" % 14 => 014
        "%.3d" % (current_migration_number(dirname) + 1)
      end
    end

    def create_migration_file
      # instance method from Rails::Generators::Migration. accepts the template source and destination of generated migration file
      # Appends next_migration_number to file name provided (checkmarks_migration.rb)
      migration_template 'migration.rb', 'db/migrate/checkmarks_migration.rb'
    end
  end
end
