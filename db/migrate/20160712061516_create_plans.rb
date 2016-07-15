class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :name #套餐名
      t.integer :may_receive, null:false, default: 0 #可接收简历数
      t.integer :may_release, null:false, default: 0 #可发布简历数
      t.integer :may_set_top, null:false, default: 0 #可置顶简历数
      t.integer :may_view, null:false, default: 0 #可预览简历数
      t.integer :may_join_fairs, null:false, default: 0 #可参加专场数
      t.boolean :status, null:false, default: true  #套餐状态

      t.timestamps null: false
    end
  end
end
