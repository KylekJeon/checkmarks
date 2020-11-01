require 'active_record'

require 'checkmarks/checkmarks'
require 'checkmarks/checkable'
require 'checkmarks/checker'
require 'checkmarks/checkmark'

# Add in methods from the Checkmarks class as class methods to the ActiveRecord::Base class.
ActiveRecord::Base.send :include, Checkmarks

# ActiveRecord::Migration post major version 5 must utilize MIGRATION[5.0]
# 
Checkmarks::MIGRATION_BASE_CLASS = if ActiveRecord::VERSION::MAJOR >= 5
  ActiveRecord::Migration[5.0]
else
  ActiveRecord::Migration
end
