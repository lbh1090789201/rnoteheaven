class CreateExpectJobs < ActiveRecord::Migration
  def change
    create_table :expect_jobs do |t|
      # 期望工作
      t.references :user #用户id

      t.string :name # 职位
      t.string :job_type # 工作类型
      t.string :location # 期望城市
      t.string :expected_salary_range # 期望薪水
      t.string :job_desc # 补充说明
      t.boolean :is_top # 是否置顶
      t.datetime :is_top_at # 置顶时间

      t.timestamps null: false
    end
  end
end
