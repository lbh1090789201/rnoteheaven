class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.references :user, :null => false

      t.string :title # 文章标题
      t.text :content # 文章主题内容
      t.string :author # 作者
      t.integer :amount, :null => false, :default => 0 #阅读量

      t.timestamps null: false
    end
  end
end
