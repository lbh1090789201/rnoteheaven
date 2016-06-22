require 'rails_helper'

RSpec.describe Employer, type: :model do
  before :each do
    @user = create(:user)
    @hospital = create(:hospital)
    @employer = create(:employer, user_id: @user.id, hospital_id: @hospital.id)
  end

  it "test employer get_hospital" do
    res = Employer.get_hospital @user.id
    expect(res).to eq(@hospital)
  end

  it "test vip get_status" do
    @employer[:may_receive] = 100
    @employer[:may_release] = 100
    @employer[:may_set_top] = 10
    @employer[:may_view] = 200
    @employer.save!

    res = Employer.get_status @user.id

    expect(res["may_receive"]).to eq(true)
  end

  it "test vip_count uid, prop " do
    res = Employer.vip_count @user.id, "has_view"
    
    expect(res).to eq(true)
  end

end
