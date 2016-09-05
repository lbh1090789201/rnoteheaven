class ChangeJobDescToExpectJobs < ActiveRecord::Migration
  def up
    change_column :expect_jobs, :job_desc, :text
  end

  def down
    change_column :expect_jobs,  :job_desc, :string
  end
end
