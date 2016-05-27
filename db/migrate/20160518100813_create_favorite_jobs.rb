class CreateFavoriteJobs < ActiveRecord::Migration
  def change
    #收藏职位
    create_table :favorite_jobs do |t|
      t.references :user　#用户id
      t.references :job　#职位id

      t.datetime :collected_at #

      t.timestamps null: false
    end
  end
end
