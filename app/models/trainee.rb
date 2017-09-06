class Trainee < ApplicationRecord
  # Associations
  has_many :submissions, dependent: :destroy
  has_one :tracked_verdict, dependent: :destroy
  accepts_nested_attributes_for :tracked_verdict, :update_only => true
  # Enums
  enum tracking_status: [:not_tracked, :tracked]
  # Callbacks
 
  # Methods
end
