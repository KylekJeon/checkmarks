module Checkable
  module ClassMethods
  end

  module InstanceMethods
    def unchecked?(checker)
      Checkmark.exists?(checker_id: checker.id, checkable: self)
    end

    def mark_as_checked!(options)
      checker = options[:for]

      Checkmark.find_by(checker_id: checker.id, checkable: self).destroy
    end
  end

  module Scopes
  end
end