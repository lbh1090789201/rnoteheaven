require 'rails_helper'

RSpec.describe Job, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  before :each do
    @hospital1 = create :hospital
    @hospital2 = create :hospital2
  end

  it "is valid to create Job" do
    job = build(:job)
    expect(job).to be_valid
  end

  it "test Job.get_seekers rid" do
    user = create :user
    user2 = create :user2
    resume = create :resume, user_id: user.id
    resume = create :resume, user_id: user2.id
    expect_job = create(:expect_job, user_id: user.id)
    expect_job2 = create(:expect_job, user_id: user2.id)
    job = create :job, :hospital_id => @hospital1.id
    apply_record = create(:apply_record, job_id: job.id, user_id: user.id, hospital_id: @hospital1.id)
    apply_record2 = create(:apply_record, job_id: job.id, user_id: user2.id, hospital_id: @hospital1.id)

    res = Job.get_seekers job.id
    expect(res.length).to eq(6)
  end

  describe 'test filters' do
    before :each do
      job = create :job, :hospital_id => @hospital1.id
      job2 = create :job2, :hospital_id => @hospital2.id
      job3 = create :job3, :hospital_id => @hospital1.id
      job4 = create :job4, :hospital_id => @hospital2.id
    end

    it "test filter name" do
      expect(Job.filter_job_name("护士").size).to eq(2)
    end

    it "test filter name" do
      expect(Job.filter_location("深圳").size).to eq(2)
    end

    it "test filter name" do
      expect(Job.filter_location("深圳市").size).to eq(1)
    end

    it "test filter name" do
      expect(Job.filter_location("深圳").filter_job_name("护士").size).to eq(1)
    end

    it "test filter hospital name" do
      expect(Job.filter_hospital_name(@hospital1.name).size).to eq(2)
    end

  end

  it "test time_left jid" do
    job = create :job

    res = Job.time_left job.id
    expect(res).to eq(60)
  end

  it "test left_refresh_time time" do
    time = (Time.now - 5.days)
    time2 = (Time.now - 10.days)

    res = Job.left_refresh_time time
    res2 = Job.left_refresh_time time2

    expect(res).to eq(2)
    expect(res2).to eq(-1)
  end
end
