class CreateApplyRecords < ActiveRecord::Migration
  def change
    create_table :apply_records do |t|
      t.references :resume #简历id
      t.references :user #用户id
      t.references :job #职位 id
      t.references :hospital #医院id

      t.datetime :end_at #结束时间
      t.datetime :view_at #查看时间
      t.datetime :recieve_at #接收时间

      t.string :from, null: false, default: "common" #投递方式 1.common 2.fari_id
      t.string :resume_status #应聘状态 1.筛选 2.面试 3.不合适
      t.boolean :has_new, null: false, default: false #Employer 更新应聘状态

      # 关于职位冗余信息
      t.string :job_name #职位名称
      t.string :job_type #工作类型
      t.string :job_location #工作地点
      t.string :salary_range #薪酬
      t.string :hospital_region #地区

      # 求职者冗余信息
      t.string :show_name #姓名
      t.string :sex #性别
      t.integer :age #年龄
      t.string :highest_degree #最高学历
      t.string :start_work_at #工作年限

      t.timestamps null: false
    end
  end
end
