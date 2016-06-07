class CreateBlockHospitals < ActiveRecord::Migration
  def change
    create_table :block_hospitals do |t|
      t.references :user #用户id
      t.references :hospital #医院id

      t.timestamps null: false
    end
  end
end
