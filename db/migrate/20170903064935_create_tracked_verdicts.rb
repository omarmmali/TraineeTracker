class CreateTrackedVerdicts < ActiveRecord::Migration[5.1]
  def change
    create_table :tracked_verdicts do |t|
      t.boolean :submission_error, default: true
      t.boolean :cant_be_judged, default: true
      t.boolean :in_queue, default: true
      t.boolean :compile_error, default: true
      t.boolean :restricted_function, default: true
      t.boolean :runtime_error, default: true
      t.boolean :output_limit, default: true
      t.boolean :time_limit, default: true
      t.boolean :memory_limit, default: true
      t.boolean :wrong_answer, default: true
      t.boolean :presentation_error, default: true
      t.boolean :accepted, default: true
      t.integer :trainee_id
      
      t.timestamps
    end
  end
end
