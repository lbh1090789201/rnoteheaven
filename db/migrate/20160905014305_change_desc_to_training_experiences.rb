class ChangeDescToTrainingExperiences < ActiveRecord::Migration
  def up
    change_column :training_experiences, :desc, :text
  end

  def down
    change_column :training_experiences,  :desc, :string
  end
end
