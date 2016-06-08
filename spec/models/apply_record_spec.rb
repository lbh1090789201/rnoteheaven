require 'rails_helper'

RSpec.describe ApplyRecord, type: :model do

  it "is valid to create apply_record" do
    apply_record = create(:apply_record)
    expect(apply_record).to be_valid
  end

  it "return if user has applied job" do
    @user = create(:user)
    @job = create(:job)
    @apply_record = create(:apply_record, user_id: @user.id, job_id: @job.id)

    res = ApplyRecord.is_applied(@user.id,  @job.id)
    res2 = ApplyRecord.is_applied(@user.id,  nil)

    expect(res).to eq(true)
    expect(res2).to eq(false)
  end
end
