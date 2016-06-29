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

  it "test check_vip" do
    apply_record = create(:apply_record, hospital_id: @hospital.id)
    apply_record2 = create(:apply_record, hospital_id: @hospital.id)
    job = create(:job, hospital_id: @hospital.id, status: "saved", is_top: true)
    job2 = create(:job, hospital_id: @hospital.id, status: "reviewing", is_top: true)
    job3 = create(:job, hospital_id: @hospital.id, status: "release", is_top: false)
    resume_viewer = create(:resume_viewer, hospital_id: @hospital.id)
    resume_viewer2 = create(:resume_viewer, hospital_id: @hospital.id)

    res = Employer.check_vip @user.id
    expect(res.has_receive).to eq(2)
    expect(res.has_release).to eq(2)
    expect(res.has_set_top).to eq(1)
    expect(res.has_view).to eq(2)
  end

  it "test vip_count uid, prop " do
    res = Employer.vip_count @user.id, "has_view"

    expect(res).to eq(true)
  end

end
