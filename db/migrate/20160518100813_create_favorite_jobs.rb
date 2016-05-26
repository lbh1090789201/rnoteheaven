class CreateFavoriteJobs < ActiveRecord::Migration
  def change
    create_table :favorite_jobs do |t|
      t.references :user
      t.references :job
      t.datetime :collected_at

      t.timestamps null: false
    end
  end
end
