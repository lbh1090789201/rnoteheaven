class CreateEducationExperiences < ActiveRecord::Migration
  def change
    create_table :education_experiences do |t|
      t.references :user

      t.string :college
      t.string :education_degree
      t.datetime :graduated_at
      t.string :major

      t.timestamps null: false
    end
  end
end
