require 'rails_helper'

RSpec.describe Job, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  it "is valid to create Job" do
    job = build(:job)
    expect(job).to be_valid

  end

  describe 'test filters' do
    before :each do
      job = create :job
      job2 = create :job2
      job3 = create :job3
      job4 = create :job4
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

  end
end
