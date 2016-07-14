require 'rails_helper'

RSpec.describe FairHospital, type: :model do
  it "test FairHospital.statistic fair_hospital" do
    @hospital = create(:hospital)
    @job = create(:job, hospital_id: @hospital.id)
    @job2 = create(:job, hospital_id: @hospital.id)
    @fair = create(:fair)
    @fair_hospital = create(:fair_hospital, fair_id: @fair.id, hospital_id: @hospital.id)
    @apply_record = create(:apply_record, from: @fair.id, hospital_id: @hospital.id)
    @apply_record2 = create(:apply_record, from: @fair.id, hospital_id: @hospital.id)

    res = FairHospital.statistic @fair_hospital
    expect(res["jobs_count"]).to eq(2)
    expect(res["resumes_count"]).to eq(2)
  end
end
