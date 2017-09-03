# Adding name attribute to Trainee model
# for styling purposes
class AddingNameToTrainee < ActiveRecord::Migration[5.1]
  def change
    add_column :trainees, :name, :string
  end
end
