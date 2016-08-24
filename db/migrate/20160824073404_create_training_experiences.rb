class CreateTrainingExperiences < ActiveRecord::Migration
  def change
    create_table :training_experiences do |t|
      t.references :user

      t.string :name #培训名称
      t.datetime :started_at #开始时间
      t.datetime :ended_at #结束时间
      t.string :desc #培训内容
      t.string :certificate #所获证书

      t.timestamps null: false
    end
  end
end
