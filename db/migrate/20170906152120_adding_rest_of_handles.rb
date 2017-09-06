class AddingRestOfHandles < ActiveRecord::Migration[5.1]
  def change
    add_column :trainees, :spoj_handle, :string
    add_column :trainees, :timus_handle, :string
    add_column :trainees, :uri_handle, :string
    add_column :trainees, :codechef_handle, :string
  end
end
