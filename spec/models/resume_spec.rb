require 'rails_helper'

RSpec.describe Resume, type: :model do
    it "has a valid factory" do
      expect(build(:resume)).to be_valid
    end

    it "test refresh_left" do
      @resume = create(:resume, refresh_at: Time.now - 3.days)
      @resume2 = create(:resume, refresh_at: Time.now - 8.days)
      @resume3 = create(:resume, refresh_at: nil)
      res = Resume.refresh_left(@resume.id)
      res2 = Resume.refresh_left(@resume2.id)
      res3 = Resume.refresh_left(@resume3.id)

      expect(res).to eq(4)
      expect(res2).to eq(false)
      expect(res3).to eq(false)
    end
end
