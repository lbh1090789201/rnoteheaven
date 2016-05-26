class CreateHospitals < ActiveRecord::Migration
  def change
    create_table :hospitals do |t|
      t.references :job_fair
      t.string :name
      t.string :scale
      t.string :property
      t.text :introduction #相关介绍
      t.string :region #地区
      t.string :location #地点
      t.string :image   #医院预览图

      t.timestamps null: false
    end
  end
end
