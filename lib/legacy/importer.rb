class Importer
  def self.run(model)
    if model.downcase.include?("authentication")
      klass = Authentication
      legacy_klass = "Legacy::#{model}".constantize
    else
      klass = model.constantize
      legacy_klass = "Legacy::#{klass}".constantize
    end

    puts "Deleting existing #{klass} records..."
    klass.delete_all

    puts "Reseting primary key squence for #{klass}"
    ActiveRecord::Base.connection.reset_pk_sequence!(klass.table_name)

    puts "Importing all #{legacy_klass} records..."
    legacy_klass.import_all_in_batches

    puts "flushing lookups..."
    legacy_klass.flush_lookups!
  end
end
