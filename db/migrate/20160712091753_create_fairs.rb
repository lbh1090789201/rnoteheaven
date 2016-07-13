class CreateFairs < ActiveRecord::Migration
  def change
    create_table :fairs do |t|
      t.string :name #专场名称
      t.string :creator #创建者
      t.string :banner #专场图片
      t.text :intro #专场介绍
      t.string :status #专场状态: processing 进行中， pause 暂停
      t.datetime :begain_at #开始时间
      t.datetime :end_at #结束时间

      t.timestamps null: false
    end
  end
end
