class CheckmarksMigration < Checkmarks::MIGRATION_BASE_CLASS
  def up
    create_table Checkmark, force: true do |t|
      t.references :checker,   polymorphic: true
      t.references :checkable, polymorphic: true
      t.boolean    :preserved, default: false

      t.datetime :timestamp
    end

    # Add index in order of most common usage / narrowest query returned per column. Reduce the number of columns to the minimum for optimization
    # Order of index presumes that the most common usage would be a checker (such as user), looking up all new checkmarks of a specific checkable type (such as notification),
    # followed by a checker looking up a specific checkmark (which can include the checkable_type still to increase querying speed)
    add_index Checkmark, [:checker_id, :checkable_type, :checkable_id, :checker_type], name: 'checkmarks_checker_checkable_index', unique: true
  end

  def down
    drop_table Checkmark
  end

  # In case of future need to set default options for create_table. But Engine=InnoDB DEFAULT CHARSET=utf8 seems to be the default, so will leave it commented out for now
  
  # def create_options
  #   options = ''
  #   if defined?(ActiveRecord::ConnectionAdapters::Mysql2Adapter) \
  #     && ActiveRecord::Base.connection.instance_of?(ActiveRecord::ConnectionAdapters::Mysql2Adapter)
  #     options = 'DEFAULT CHARSET=latin1'
  #   end
  #   options
  # end
end
