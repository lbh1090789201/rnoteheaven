require 'rails_helper'

RSpec.describe FavoriteJob, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  it "is valid to create FavoriteJob" do
    favorite_job = build(:favorite_job)
    expect(favorite_job).to be_valid

  end
end
