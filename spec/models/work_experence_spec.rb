require 'rails_helper'

RSpec.describe WorkExperience, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  it "is valid to create FavoriteJob" do
    expect(create(:work_experience)).to be_valid
  end
end
