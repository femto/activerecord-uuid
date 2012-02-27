module ActiveRecord
  #
  # Provide a Rails Engine, to load the initializer active_record.rb
  #
  module Uuid
    class Engine < Rails::Engine
      paths["config/initializers"] << File.expand_path("./lib/active_record/uuid/initializers")
    end
  end
end
