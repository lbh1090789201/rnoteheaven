class AddRecruitTypeToJobs < ActiveRecord::Migration
  def change
    # t.string :recruit_type, null: false, default: '' #招聘类型
    # t.string :degree_demand, null: false, default: '' #学历要求
    add_column :jobs, :recruit_type, :string # 招聘类型
    add_column :jobs, :degree_demand, :string # 学历要求
  end
end
