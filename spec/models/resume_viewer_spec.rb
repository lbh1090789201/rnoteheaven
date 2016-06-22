require 'rails_helper'

RSpec.describe ResumeViewer, type: :model do
  it "has a valid ResumeViewer factory" do
    expect(build(:resume_viewer)).to be_valid
  end

  it "test set_viewer eid, uid" do
    @user = create(:user)
    @hospital = create(:hospital)
    @employer = create(:employer, user_id: @user.id, hospital_id: @hospital.id)

    res = ResumeViewer.set_viewer @hospital.id, @user.id
    expect(res[:json][:success]).to eq(true)
  end
end
