class CreateBlockHospitals < ActiveRecord::Migration
  def change
    create_table :block_hospitals do |t|
      t.references :user #用户id
      t.references :hospital #医院id
      t.string :hospital_name #医院名称
      t.timestamps null: false
    end
  end
end
