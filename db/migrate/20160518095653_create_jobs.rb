class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.references :hospital #医院id

      t.string :name #职位名称
      t.string :job_type #工作类型
      t.string :salary_range #薪酬

      t.integer :needed_number #需求人数
      t.string :job_location #工作地点
      t.text :job_desc #职位描述

      t.boolean :is_top #工作置顶
      t.datetime :is_top_at #置顶时间


      t.timestamps null: false
    end
  end
end
