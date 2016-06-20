class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.references :hospital #医院id

      t.string :name #职位名称
      t.string :job_type #工作类型
      t.string :salary_range #薪酬

      t.integer :needed_number #需求人数
      t.string :location #工作地点
      t.text :job_desc #职位描述

      t.boolean :is_top #工作置顶
      t.datetime :is_top_at #置顶时间
      t.string :status #职位状态 1.saved 2.reviewing 3.release 4.pause 5.end 6.freeze 7.fail
      t.boolean :is_update #Admin 是否有更新

      t.datetime :release_at #发布时间
      t.datetime :end_at #结束时间
      # t.integer :time_left #剩余天数，暂停时【新建】，重新发布【清空】


      t.timestamps null: false
    end
  end
end
