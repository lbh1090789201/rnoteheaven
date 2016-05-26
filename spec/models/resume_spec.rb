require 'rails_helper'

RSpec.describe Resume, type: :model do
    it "has a valid factory" do
      expect(build(:resume)).to be_valid
    end

    # 不使用 FactoryGirl 的写法
#    it "test resume valid" do
      #resume = Resume.new(
        #last_refresh_time: "2016-05-18 17:47:41",
        #expected_job: "护士",
        #expected_job_type: "全职",
        #expected_base: "北京",
        #expected_salary_range: "5k~6k",
        #maturity: 5)
      #expect(resume).to be_valid
    #end

    
end
