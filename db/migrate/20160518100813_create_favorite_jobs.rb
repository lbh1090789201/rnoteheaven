class CreateFavoriteJobs < ActiveRecord::Migration
  def change
    #收藏职位
    create_table :favorite_jobs do |t|
      t.references :user; #用户id
      t.references :job #职位id

      t.boolean :has_new, null: false, default: false #employer 有更新
      # job 冗余数据
      t.string :name #职位名称
      t.string :job_type #工作类型
      t.string :salary_range #薪酬

      # 医院冗余数据
      t.string :region #地区

      t.datetime :collected_at
      t.timestamps null: false
    end
  end
end
