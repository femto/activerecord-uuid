require 'uuidtools'

module ActiveRecord
  module Uuid
    module Model
      def self.included(model)
        model.instance_eval do
          # This should never be user-assigned
          attr_protected :uuid
          # Validate on update since uuid won't exist yet on creation
          validates :uuid, :presence => true, :uniqueness => true, :on => :update
          before_create :assign_uuid
        end
      end
    
    private
    
      def assign_uuid
        write_attribute(:uuid, UUIDTools::UUID.timestamp_create.to_s)
      end
    end
  end
end
