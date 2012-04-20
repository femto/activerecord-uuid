module ActiveRecord
  module Uuid
    module Relation
    private
  
      # Rather than monkey-patching ActiveRecord::Relation, subclass it with our own implementation
      # of the finder methods. This is the way FriendlyId does it, and should place nicely with it.
      def uuid_relation_class    
        @uuid_relation_class ||= Class.new(relation_without_uuid.class) do
          alias_method :find_one_without_uuid, :find_one
          alias_method :exists_without_uuid?, :exists?
          include Uuid::FinderMethods
        end
      end
    
      # Override the model's relation method to return our subclassed version.
      def relation
        @relation = nil unless @relation.class <= uuid_relation_class
        @relation ||= uuid_relation_class.new(self, arel_table)
        super
      end
    end
  end
end
