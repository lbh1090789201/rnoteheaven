class CreateRecommends < ActiveRecord::Migration
  def change
    create_table :recommends do |t|
      t.references :user
      t.references :note

      t.integer :recom_amount #推荐数

      t.timestamps null: false
    end
  end
end
