class CreateEmployers < ActiveRecord::Migration
  def change
    create_table :employers do |t|
      t.references :user
      t.references :hospital
      t.references :plan

      # vip 信息
      t.integer :vip_level, null:false, default: 1 # vip 等级

      t.integer :may_receive, null:false, default: 0 #可接收简历
      t.integer :may_release, null:false, default: 0 #可发布简历
      t.integer :may_set_top, null:false, default: 0 #可置顶简历
      t.integer :may_view, null:false, default: 0 #可查看简历
      t.integer :may_join_fairs, null:false, default: 0 #可参加专场数

      t.integer :has_receive, null:false, default: 0 #已接收简历
      t.integer :has_release, null:false, default: 0 #已发布简历
      t.integer :has_set_top, null:false, default: 0 #已置顶简历
      t.integer :has_view, null:false, default: 0 #已查看简历
      t.integer :has_join_fairs, null:false, default: 0 #已参加专场数

      t.timestamps null: false
    end
  end
end
