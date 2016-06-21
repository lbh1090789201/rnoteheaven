class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.references :hospital #医院id

      t.string :name #职位名称
      t.string :job_type #工作类型
      t.string :salary_range #薪酬
      t.string :experience #经验要求
      t.integer :needed_number #需求人数
      t.string :region #工作地区
      t.string :location #上班地址
      t.text :job_desc #职位描述
      t.text :job_demand #任职资格

      t.string :status #职位状态 1.saved 2.reviewing 3.release 4.pause 5.end 6.freeze 7.fail
      t.boolean :is_update, null: false, default: false #Admin 有更新

      t.datetime :release_at #发布时间
      t.datetime :refresh_at #刷新时间
      t.datetime :end_at #结束时间

      t.timestamps null: false
    end
  end
end
