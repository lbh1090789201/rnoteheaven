class CreateFairHospitals < ActiveRecord::Migration
  def change
    create_table :fair_hospitals do |t|
      t.references :hospital
      t.references :fair
      t.references :user #操作者ID

      t.string :contact_person #联系人
      t.string :contact_number #手机号码
      t.string :intro #介绍
      t.string :banner #医院图片
      t.string :status #状态 on pause quit
      t.string :operator #操作人

      t.timestamps null: false
    end
  end
end
