class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.references :hospital

      t.string :name
      t.string :expected_salary_range
      t.string :location
      t.string :job_desc
      t.integer :needed_number
      t.string :job_type
      t.boolean :is_top
      t.datetime :is_top_at

      t.timestamps null: false
    end
  end
end
