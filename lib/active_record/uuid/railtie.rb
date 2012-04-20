# 
# Provide a Railtie, which changes the schema format to :sql. This in turn allows development_structure.sql to define uuid fields as the Postgresql uuid type.
#
module ActiveRecord
  module Uuid
    class Railtie < Rails::Railtie
      config.active_record.schema_format = :sql # For UUID columns and other PGSQL goodness.
    end
  end
end
