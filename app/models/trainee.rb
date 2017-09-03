class Trainee < ApplicationRecord
  # Associations
  has_many :submissions, dependent: :destroy
  has_many :tracked_verdicts, dependent: :destroy
  # Enums
  enum tracking_status: [:not_tracked, :tracked]
  # Callbacks
  after_create :create_tracked_verdicts
  # Methods
  def create_tracked_verdicts
    TrackedVerdict.create(trainee: self)
  end
end
