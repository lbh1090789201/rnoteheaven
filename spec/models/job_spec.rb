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
end
