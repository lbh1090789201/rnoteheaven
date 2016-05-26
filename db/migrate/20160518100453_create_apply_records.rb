class CreateApplyRecords < ActiveRecord::Migration
  def change
    create_table :apply_records do |t|
      t.references :resume
      t.references :job

      t.datetime :apply_at
      t.string :resume_status
      t.datetime :recieve_at
      t.datetime :view_at

      t.timestamps null: false
    end
  end
end
