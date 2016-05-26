class CreateEducationExperiences < ActiveRecord::Migration
  def change
    create_table :education_experiences do |t|
      t.references :user

      t.string :college #学校
      t.string :education_degree #学位
      t.datetime :entry_at # 入学时间
      t.datetime :graduated_at #毕业时间
      t.string :major

      t.timestamps null: false
    end
  end
end
