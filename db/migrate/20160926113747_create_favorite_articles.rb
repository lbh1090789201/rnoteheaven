class CreateFavoriteArticles < ActiveRecord::Migration
  def change
    create_table :favorite_articles do |t|
      t.references :user
      t.references :note

      t.timestamps null: false
    end
  end
end
