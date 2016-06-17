require 'rails_helper'

RSpec.describe Employer, type: :model do
  it "test employer get_hospital" do
    @hospital = create(:hospital)
    @user = create(:user)
    employer = create(:employer, user_id: @user.id, hospital_id: @hospital.id)

    res = Employer.get_hospital @user.id
    expect(res).to eq(@hospital)
  end
end
