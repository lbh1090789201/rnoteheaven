class CreateEmployers < ActiveRecord::Migration
  def change
    create_table :employers do |t|
      t.references :user
      t.references :hospital

      t.timestamps null: false
    end
  end
end
