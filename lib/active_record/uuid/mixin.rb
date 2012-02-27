require 'uuidtools'
module ActiveRecord
  # 
  # When you add a UUID field to your model, include this module for sane defaults.
  #  * The UUID field will not be mass assignable
  #  * A validation will guarantee its uniqueness and presence, during updates
  #  * A callback will execute, before creation, assigning the UUID
  module Uuid
    module Mixin
      extend ActiveSupport::Concern
      
      included do |base|
        attr_protected :uuid
        # Validate on update since uuid won't exist yet on creation.
        validates :uuid, :presence => true, :uniqueness => true, :on => :update
        before_create :assign_uuid
      end
      
      module InstanceMethods
        # 
        # Set the object's UUID, using UUIDTools::UUID.timestamp_create
        #
        def assign_uuid
          write_attribute(:uuid, UUIDTools::UUID.timestamp_create.to_s)
        end
      end
    end
  end
end
