class CreateHospitals < ActiveRecord::Migration
  def change
    create_table :hospitals do |t|
      t.references :job_fair
      t.string :name
      t.string :scale
      t.string :property
      t.string :location
      t.string :introduction
      t.string :region
      t.string :image   #医院预览图

      t.timestamps null: false
    end
  end
end
