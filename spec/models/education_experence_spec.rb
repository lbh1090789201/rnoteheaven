require 'rails_helper'

RSpec.describe EducationExperience, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  def test_use_valid_education_experience_from_factory_girl
   education_experience = build(:education_experience)
   assert education_experience.valid?
  end
  it "is valid with a college, education_degree, entry_at, graduated_at and major" do
    education_experience = create(:education_experience)
    expect(education_experience).to be_valid

  end
end
