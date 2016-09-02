class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.references :user

      t.string :name, :null => false, :default => ""  #搜索职位/机构名称
      t.string :region, :null => false, :default => ""  #搜索职位地区
      t.string :salary_range, :null => false, :default => ""  #职位薪资范围
      t.string :experience, :null => false, :default => ""  #工作经验
      t.string :degree_demand, :null => false, :default => ""  #学历要求
      t.string :recruit_type, :null => false, :default => ""  #招聘类型

      t.timestamps null: false
    end
  end
end
