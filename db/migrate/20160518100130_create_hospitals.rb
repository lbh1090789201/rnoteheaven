class CreateHospitals < ActiveRecord::Migration
  def change
    create_table :hospitals do |t|
      t.references :job_fair

      t.string :name #医院名称
      t.string :scale #规模
      t.string :property #医院性质，例如：公立、私立、社区医院
      t.string :region #地区
      t.string :location #地点
      t.text :introduction #相关介绍
      t.string :image   #医院预览图

      t.timestamps null: false
    end
  end
end
