module ActiveRecord
  module Uuid
    module FinderMethods
      VALID_UUID = /[0-9A-F]{32}/i
    
      # Ultimately, many methods call #find_one rather than simply just #find. Overriding just
      # this allows more things to just work properly.
      def find_one(id)
        if id.to_s.gsub('-', '') =~ VALID_UUID && record = where(:uuid => id).limit(1).first
          record
        else
          super(id)
        end
      end
      
      def exists?(id = false)
        if id.to_s.gsub('-', '') =~ VALID_UUID
          super :uuid => id
        else
          super
        end
      end
    end
  end
end
