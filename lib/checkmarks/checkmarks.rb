module Checkmarks
  def self.included(base)
    debugger
    base.extend Base
  end

  module Base
    def set_as_checker 
      Checkmark.checker_classes ||= []

      unless Checkmark.checker_classes.include?(self)
        has_many :checkmarks, as: :checker, dependent: :delete_all, inverse_of: :checker

        Checkmark.checker_classes << self

        include Checker::InstanceMethods
        extend Checker::ClassMethods
        extend Checker::Scopes
      end
    end

    def set_as_checkable(options={})
      Checkmark.checkable_classes ||= []

      unless Checkmark.checkable_classes.include?(self)
        has_many :checkmarks, as: :checkable, dependent: :delete_all, inverse_of: :checkable

        Checkmark.checkable_classes << self

        include Checkable::InstanceMethods
        extend Checkable::ClassMethods
        extend Checkable::Scopes
      end
    end
  end
  
end