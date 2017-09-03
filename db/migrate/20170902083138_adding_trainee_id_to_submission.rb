# Adding trainee_id to the Submission model
# to create the 1:M association between the two models
class AddingTraineeIdToSubmission < ActiveRecord::Migration[5.1]
  def change
    add_column :submissions, :trainee_id, :integer
  end
end
