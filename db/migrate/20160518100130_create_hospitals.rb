class CreateHospitals < ActiveRecord::Migration
  def change
    create_table :hospitals do |t|
      t.references :job_fair

      t.string :name #医院名称
      t.string :property #类型，例如：公立、私立、社区医院
      t.string :scale #规模
      t.string :industry #行业
      t.string :region #地区
      t.string :location #地址
      t.text :introduction #相关介绍
      t.string :image   #医院预览图
      t.float :lat, default: 30.598428 #纬度
      t.float :lng, default: 114.311831 #经度
      t.string :contact_person #负责人
      t.string :contact_number #手机号码

      t.timestamps null: false
    end
  end
end
