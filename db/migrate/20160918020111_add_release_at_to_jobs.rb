class AddReleaseAtToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :release_at, :datetime # 发布时间
  end
end
