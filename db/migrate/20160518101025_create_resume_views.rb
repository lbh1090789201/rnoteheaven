class CreateResumeViews < ActiveRecord::Migration
  def change
    create_table :resume_views do |t|
      t.references :user
      t.references :hospital

      t.datetime :view_at

      t.timestamps null: false
    end
  end
end
