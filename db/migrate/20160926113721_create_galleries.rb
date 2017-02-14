class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :galleries do |t|

      t.string :image # 图片

      t.timestamps null: false
    end
  end
end
