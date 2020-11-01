module Checkmarks
  module Checker
    module ClassMethods
    end

    module InstanceMethods
      def mark_as_checkable(checkables:, preserved: false)
        checkables = [*checkables]
        
        checkmarks = checkables.map { |checkable| { checker: self, checkable: checkable, preserved: preserved }}        
        
        # Bulk create checkmarks
        Checkmark.create(checkmarks)
      end

      def mark_as_checked(checkables:)
        checkables = [*checkables]

        # bulk delete checkmarks
        Checkmark.where(checker: self, checkable: checkables , preserved: false).delete_all
      end

      def fetch_checkable_by_class(checkable_class)
        checkable_class.joins(:checkmarks).where(checkmarks: { checker_id: self.id, checkable_type: checkable_class.name })
      end
      
      def fecth_checkmarks_by_class(checkable_class)
        Checkmark.where(checker_id: self.id, checkable_type: checkable_class.name)
      end
    end

    module Scopes
    end
  end
end