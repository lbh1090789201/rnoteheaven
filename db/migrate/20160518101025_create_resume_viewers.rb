class CreateResumeViewers < ActiveRecord::Migration
  def change
    # 谁看过我的简历
    create_table :resume_viewers do |t|
      t.references :user #用户id
      t.references :hospital #医院id

      t.datetime :view_at #查看时间
      t.timestamps null: false
    end
  end
end
