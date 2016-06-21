require 'rails_helper'

RSpec.describe FavoriteJob, type: :model do
  before :each do
    @user = create(:user)
    @user2 = create(:user2)
    @job = create(:job)
    @favorite_job = create(:favorite_job, user_id: @user.id, job_id: @job.id)
    @favorite_job2 = create(:favorite_job, user_id: @user2.id, job_id: @job.id)
  end

  it "is valid to create FavoriteJob" do
    favorite_job = build(:favorite_job)
    expect(favorite_job).to be_valid
  end

  it "test is_favor" do
    res = FavoriteJob.is_favor(@user.id, @job.id)
    res2 = FavoriteJob.is_favor(@user.id, nil)
    expect(res).to eq(true)
    expect(res2).to eq(false)
  end

  it "test set_new" do
    res = FavoriteJob.set_new @job.id

    expect(res.first.has_new).to eq(true)
  end
end
