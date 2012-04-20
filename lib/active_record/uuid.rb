require 'active_record/uuid/finder_methods'
require 'active_record/uuid/model'
require 'active_record/uuid/railtie'
require 'active_record/uuid/relation'
require 'active_record/uuid/version'

module ActiveRecord
  module Uuid    
    def self.included(model)
      class << model
        alias_method :relation_without_uuid, :relation
      end
    
      model.instance_eval do
        extend Relation
        include Model
      end
    end
  end
end
