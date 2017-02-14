class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user
      t.references :note

      t.text :content # 评论内容

      t.timestamps null: false
    end
  end
end
