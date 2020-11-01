class Checkmark < ActiveRecord::Base
  # Polymorphic joins table
  belongs_to :checkable, polymorphic: true, inverse_of: :checkmarks
  belongs_to :checker, polymorphic: true, inverse_of: :checkmarks        

  # presence of polymorphic id and type validated by rails, not at the db level to allow more flexibility and customization.
  validates_presence_of :checker_id, :checker_type, :checkable_type

  scope :global, -> { where(checkable_id: nil) }
  scope :single, -> { where("checkable_id IS NOT NULL") }
  scope :older_than, -> (timestamp) { where('timestamp < ?', timestamp)}

  # Returns the classes defined by acts_as_checker
  class_attribute :checker_classes, default: []

  # Returns the classes defined by acts_as_checkable
  class_attribute :checkable_classes, default: []
end