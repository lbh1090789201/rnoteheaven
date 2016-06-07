class CreateApplyRecords < ActiveRecord::Migration
  def change
    create_table :apply_records do |t|
      t.references :resume #简历id
      t.references :user # 用户id
      t.references :job # 职位 id
      t.references :hospital #医院id

      t.datetime :end_at # 结束时间
      t.datetime :apply_at # 筛选时间
      t.datetime :view_at # 查看时间
      t.datetime :recieve_at # 接收时间

      t.string :resume_status #简历状态

      # 关于职位冗余信息
      t.string :job_name #职位名称
      t.string :job_type #工作类型
      t.string :job_location #工作地点
      t.string :salary_range #薪酬
      t.string :hospital_region #地区

      t.timestamps null: false
    end
  end
end
