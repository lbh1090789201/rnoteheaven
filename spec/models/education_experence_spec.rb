require 'rails_helper'

RSpec.describe EducationExperience, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  def test_use_valid_education_experience_from_factory_girl
   education_experience = build(:education_experience)
   assert education_experience.valid?
  end
  describe "when " do

  end
end
