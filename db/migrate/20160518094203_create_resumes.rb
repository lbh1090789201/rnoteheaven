class CreateResumes < ActiveRecord::Migration
  def change
    create_table :resumes do |t|
      t.references :user

      t.datetime :refresh_at
      t.string :expected_job
      t.string :expected_job_type
      t.string :expected_base
      t.string :expected_salary_range
      t.integer :maturity, :null => false, :default => 0 #完成度
      t.boolean :public, :null => false, :default => true # 简历公开
      t.boolean :resume_freeze, :null => false, :default => false # 简历冻结

      t.timestamps null: false
    end
  end
end
