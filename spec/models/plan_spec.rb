require 'rails_helper'

RSpec.describe Plan, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  before :each do
   @hospital = create(:hospital)
   @user = create(:user)
   @employer = create(:employer, user_id: @user.id, hospital_id: @hospital.id)
   @plan = create(:plan)
  end

  it "test filter_by_name" do
    expect(Plan.filter_by_name('vip1').size).to eq(1)
  end

  it "test filter_by_status" do
    plan = Plan.filter_by_status(true)
    expect(plan.size).to eq(1)
  end

end
