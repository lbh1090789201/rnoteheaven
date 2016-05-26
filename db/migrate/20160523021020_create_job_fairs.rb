class CreateJobFairs < ActiveRecord::Migration
  def change
    create_table :job_fairs do |t|
      t.string :name
      t.datetime :timeout
      t.string :tips
      t.integer :entry_num

      t.timestamps null: false
    end
  end
end
