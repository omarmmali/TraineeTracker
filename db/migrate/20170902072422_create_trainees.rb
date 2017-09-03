# Creating the Trainee model
# uva_handle: is the trainee's uva handle, we use it to get the trainee's
# uhunt id, to get the trainee's UVa submissions
# live_archive_handle: is the trainee's live archive handle, we use it to get
# the trainee's live archive submissions
# codeforces_handle: is the trainee's codeforces handle, we use it to get
# the trainee's codeforces submissions
class CreateTrainees < ActiveRecord::Migration[5.1]
  def change
    create_table :trainees do |t|
    	t.string :uva_handle
    	t.string :live_archive_handle
    	t.string :codeforces_handle
    	
    	t.timestamps
    end
  end
end
