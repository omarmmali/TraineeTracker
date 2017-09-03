# Adding tracking_status to Trainee model
# tracking_status is used to enable and disable tracking for a specific trainee
class AddingTrackingStatusToTrainee < ActiveRecord::Migration[5.1]
  def change
    add_column :trainees, :tracking_status, :integer, default: 0
  end
end
