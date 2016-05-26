class CreateResumes < ActiveRecord::Migration
  def change
    create_table :resumes do |t|
      t.references :user

      t.datetime :last_refresh_time
      t.string :expected_job
      t.string :expected_job_type
      t.string :expected_base
      t.string :expected_salary_range
      t.integer :maturity

      t.timestamps null: false
    end
  end
end
