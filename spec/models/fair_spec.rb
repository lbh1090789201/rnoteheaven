require 'rails_helper'

RSpec.describe Fair, type: :model do
  it "test model create" do
    res = build(:fair)
    expect(res).to be_valid
  end

  describe "Fair filter" do
    before :each do
      @fair = create(:fair)
      @fair2 = create(:fair, name: '小护士专场', begain_at: Time.now + 5.days)
      @fair3 = create(:fair, name: '小医生专场', status: 'pause')
    end

    it 'test filter_by_name' do
      res = Fair.filter_by_name '小'
      expect(res.length).to eq(2)
    end

    it 'test filter_by_status' do
      res = Fair.filter_by_status 'pause'
      expect(res.length).to eq(1)
    end

    it 'test filter_begain_at' do
      res = Fair.filter_begain_at Time.now + 1.day
      expect(res.length).to eq(1)
    end

    it 'test filter_end_at' do
      res = Fair.filter_end_at Time.now + 1.day
      expect(res.length).to eq(2)
    end
  end

  it "test Fair.get_info fairs" do
    @hospital = create(:hospital)
    @hospital2 = create(:hospital)
    @job = create(:job, hospital_id: @hospital.id)
    @job2 = create(:job, hospital_id: @hospital2.id)
    @job3 = create(:job, hospital_id: @hospital2.id)
    @fair = create(:fair)
    @fair_hospital = create(:fair_hospital, fair_id: @fair.id, hospital_id: @hospital.id)
    @fair_hospital2 = create(:fair_hospital, fair_id: @fair.id, hospital_id: @hospital2.id)
    @apply_record = create(:apply_record, from: @fair.id)
    @apply_record2 = create(:apply_record, from: @fair.id)

    res = Fair.fair_statistic @fair
    expect(res["hospitals_count"]).to eq(2)
    expect(res["jobs_count"]).to eq(3)
    expect(res["resumes_count"]).to eq(2)
  end

end
