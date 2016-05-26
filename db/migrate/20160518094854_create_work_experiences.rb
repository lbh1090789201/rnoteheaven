class CreateWorkExperiences < ActiveRecord::Migration
  def change
    create_table :work_experiences do |t|
      t.references :resume
      t.references :user

      t.string :company
      t.string :position
      t.datetime :started_at
      t.datetime :left_time
      t.text :job_desc #工作内容

      t.timestamps null: false
    end
  end
end
