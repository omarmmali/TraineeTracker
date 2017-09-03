# Creating the Submission model
# It is used to save submissions made by a trainee
# to make tracking the sumbissions easier
# problem_judge: is the problem's hosting online judge
# problem_id: is the problem's id on the hosting online judge
# verdict: is an enumeration that tracks the state of the submission, i.e AC, WA
class CreateSubmissions < ActiveRecord::Migration[5.1]
  def change
    create_table :submissions do |t|
    	t.string :problem_judge
    	t.string :problem_id
    	t.integer :verdict

      t.timestamps
    end
  end
end
