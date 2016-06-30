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
      job = create :job, :hospital_id => @hospital1.id, :operate_at => Time.now - 5.days
      job2 = create :job2, :hospital_id => @hospital2.id, :status => "saved" , :operate_at => Time.now - 3.days
      job3 = create :job3, :hospital_id => @hospital1.id, :status => "release", :operate_at => Time.now - 1.days
      job4 = create :job4, :hospital_id => @hospital2.id, :operate_at => Time.now, :job_type => "全科"
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

    it "test filter status" do
      expect(Job.filter_job_status("saved").size).to eq(2)
    end

    it "test filter_release_before" do
      expect(Job.filter_release_before(Time.now - 2.days).size).to eq(2)
    end

    it "test filter_release_after" do
      expect(Job.filter_release_after(Time.now - 4.days).size).to eq(3)
    end

    it "test filter_job_type" do
      expect(Job.filter_job_type("全科").size).to eq(1)
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

  it "test get_edu_num" do
    aa = "本科"
    bb = nil
    cc = "未知"

    res1 = Job.get_edu_num aa
    res2 = Job.get_edu_num bb
    res3 = Job.get_edu_num cc

    expect(res1).to eq(4)
    expect(res2).to eq(0)
    expect(res3).to eq(0)
  end

  it "test get_exp_num" do
    aa = "在读学生"
    bb = nil
    cc = "10年以上"

    res1 = Job.get_exp_num aa
    res2 = Job.get_exp_num bb
    res3 = Job.get_exp_num cc

    expect(res1).to eq(0)
    expect(res2).to eq(0)
    expect(res3).to eq(14)
  end
end
