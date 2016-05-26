class CreateWorkExperiences < ActiveRecord::Migration
  def change
    create_table :work_experiences do |t|
      t.references :resume

      t.string :company
      t.string :position
      t.datetime :started_at
      t.datetime :left_time
      t.string :job_desc

      t.timestamps null: false
    end
  end
end
