class CreateEventLogs < ActiveRecord::Migration
  def change
    create_table :event_logs do |t|
      t.references :user #操作者ID
      t.string :show_name #操作者姓名
      t.string :table #被操作表名
      t.integer :obj_id #被操作对象ID
      t.string :object_name #被操作对象姓名
      t.string :action #操作名称
      t.timestamps null: false
    end
  end
end
