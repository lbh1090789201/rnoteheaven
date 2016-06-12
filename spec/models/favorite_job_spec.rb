require 'rails_helper'

RSpec.describe FavoriteJob, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  it "is valid to create FavoriteJob" do
    favorite_job = build(:favorite_job)
    expect(favorite_job).to be_valid
  end

  it "test is_favor" do
    @user = create(:user)
    @job = create(:job)
    @favorite_job = create(:favorite_job, user_id: @user.id, job_id: @job.id)

    res = FavoriteJob.is_favor(@user.id, @job.id)
    res2 = FavoriteJob.is_favor(@user.id, nil)
    expect(res).to eq(true)
    expect(res2).to eq(false)
  end
end
